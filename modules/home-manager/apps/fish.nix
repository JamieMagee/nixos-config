{ pkgs, config, ... }:
let
  sources = import ../../../nix/sources.nix;
in {

  environment.sessionVariables.SHELL = "fish";
  home-manager.users.jamie.programs.fish = {
    enable = true;
    plugins = let
      sourcesFishPlugin = pname:
      {
        name = pname;
        src = pkgs.fetchFromGitHub {
          owner = sources.${pname}.owner;
          repo = sources.${pname}.repo;
          rev = sources.${pname}.rev;
          sha256 = sources.${pname}.sha256;
        };
      };
      in map sourcesFishPlugin [
        "fzf"
        "pisces"
        "plugin-bang-bang"
        "theme-bobthefish"
        "z"
      ];
  };
}