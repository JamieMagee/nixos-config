{ home, lib, nixos, unstable, pkgset, self, system, utils, ... }:
let
  inherit (utils) recImport;
  inherit (builtins) attrValues removeAttrs;
  inherit (pkgset) osPkgs pkgs;

  config = hostName:
    lib.nixosSystem {
      inherit system;

      modules = let
        inherit (home.nixosModules) home-manager;

        core = self.nixosModules.profiles.core;

        global = {
          networking.hostName = hostName;
          nix.nixPath = let path = toString ../.;
          in [
            "nixpkgs=${unstable}"
            "nixos=${nixos}"
            "nixos-config=${path}/configuration.nix"
            "nixpkgs-overlays=${path}/overlays"
          ];

          nixpkgs = { pkgs = osPkgs; };

          nix.registry = {
            nixos.flake = nixos;
            nixflk.flake = self;
            nixpkgs.flake = unstable;
          };
        };


        mkHomeManagerConfiguration = { system, name, config, username, homeDirectory }:
          home.lib.homeManagerConfiguration {
            inherit system pkgs username homeDirectory;
            configuration = { ... }: {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = let
                override = import ../pkgs/override.nix pkgs;

                overlay = pkg: final: prev: { "${pkg.pname}" = pkg; };
              in map overlay override;
              imports = [
                self.lib.home-manager-common
      
                (import config)
              ];
            };
          };

        overrides = {
          # use latest systemd
          systemd.package = pkgs.systemd;

          nixpkgs.overlays = let
            override = import ../pkgs/override.nix pkgs;

            overlay = pkg: final: prev: { "${pkg.pname}" = pkg; };
          in map overlay override;
        };

        local = import "${toString ./.}/${hostName}.nix";

        # Everything in `./modules/list.nix`.
        flakeModules =
          attrValues (removeAttrs self.nixosModules [ "profiles" ]);

      in flakeModules ++ [ core global local home-manager overrides mkHomeManagerConfiguration ];

    };

  hosts = recImport {
    dir = ./.;
    _import = config;
  };
in hosts
