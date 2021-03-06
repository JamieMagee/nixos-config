{ config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in {
  nix.package = pkgs.nixFlakes;

  nix.systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

  environment = {

    systemPackages = with pkgs; [
      binutils
      coreutils
      curl
      deploy-rs
      direnv
      dnsutils
      dosfstools
      fd
      git
      gotop
      gptfdisk
      iputils
      jq
      manix
      moreutils
      nix-index
      nmap
      ripgrep
      tealdeer
      utillinux
      whois
    ];

    shellInit = ''
      export STARSHIP_CONFIG=${
        pkgs.writeText "starship.toml" (fileContents ./starship.toml)
      }
    '';

    shellAliases = let ifSudo = lib.mkIf config.security.sudo.enable;
    in {
      # quick cd
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # git
      g = "git";

      # grep
      grep = "rg";
      gi = "grep -i";

      # internet ip
      myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

      # nix
      n = "nix";
      np = "n profile";
      ni = "np install";
      nr = "np remove";
      ns = "n search --no-update-lock-file";
      nf = "n flake";
      nepl = "n repl '<nixpkgs>'";
      srch = "nsni";
      nrb = ifSudo "sudo nixos-rebuild";
      mn = ''
        manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix
      '';

      # fix nixos-option
      nixos-option = "nixos-option -I nixpkgs=${toString ../../compat}";

      # sudo
      s = ifSudo "sudo -E ";
      si = ifSudo "sudo -i";
      se = ifSudo "sudoedit";

      # top
      top = "gotop";

      # systemd
      ctl = "systemctl";
      stl = ifSudo "s systemctl";
      utl = "systemctl --user";
      ut = "systemctl --user start";
      un = "systemctl --user stop";
      up = ifSudo "s systemctl start";
      dn = ifSudo "s systemctl stop";
      jtl = "journalctl";

    } // lib.mapAttrs' (n: v:
      let
        prefix = lib.concatStrings (lib.take 2 (lib.stringToCharacters n));
        ref = from:
          if from ? ref then "ns ${from.id}/${from.ref}" else "ns ${from.id}";
      in lib.nameValuePair "ns${prefix}" (ref v.from)) config.nix.registry;

  };

  fonts = {
    fonts = with pkgs; [ powerline-fonts dejavu_fonts ];

    fontconfig.defaultFonts = {

      monospace = [ "DejaVu Sans Mono for Powerline" ];

      sansSerif = [ "DejaVu Sans" ];

    };
  };

  nix = {

    autoOptimiseStore = true;

    gc.automatic = true;

    optimise.automatic = true;

    useSandbox = true;

    allowedUsers = [ "@wheel" ];

    trustedUsers = [ "root" "@wheel" ];

    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';

  };

  programs.bash = {
    promptInit = ''
      eval "$(${pkgs.starship}/bin/starship init bash)"
    '';
    interactiveShellInit = ''
      eval "$(${pkgs.direnv}/bin/direnv hook bash)"
    '';
  };

  services.earlyoom.enable = true;

  users.mutableUsers = false;

}
