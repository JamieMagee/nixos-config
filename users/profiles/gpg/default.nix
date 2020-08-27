{ lib, pkgs, config, ... }:
let inherit (lib) fileContents;
in {
  programs.gpg = { enable = true; };
  xdg.configFile."fish/lpass-pgp-pinentry.fish" = {
    source = let
      pinentry = pkgs.writeScriptBin "lpass-pgp-pinentry.fish" ''
        #!${pkgs.fish}/bin/fish
        ${fileContents ./lpass-pgp-pinentry.fish}
      '';
    in "${pinentry}/bin/lpass-pgp-pinentry.fish";
    executable = true;
  };
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 60480000;
    maxCacheTtl = 60480000;
    pinentryFlavor = null;
    extraConfig = ''
      pinentry-program ${config.xdg.configHome}/fish/lpass-pgp-pinentry.fish
    '';
  };
}
