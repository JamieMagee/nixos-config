{ config, lib, pkgs, ... }: {

  imports = [
    ../../profiles/develop
    ../../profiles/fish
    ../../profiles/applications
    ../../profiles/graphical
  ];

  home-manager.users.jamie = {
    home.stateVersion = "20.09";
    imports = [ ../profiles ];

    home.packages = with pkgs; [ jetbrains.rider ];

    nixpkgs.config.allowUnfree = true;

    home.file.".config/nixpkgs/config.nix".text = ''
      {
        ${
          lib.optionalString config.nixpkgs.config.allowUnfree
          "allowUnfree = true;"
        }
      }
    '';
  };

  users.users.jamie = {
    uid = 1000;
    password = "nixos";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIr1ZYIVMaWmhOVW3rqJS24Ffkin4XdxfMXFR5E4mt3W"
    ];
  };
}
