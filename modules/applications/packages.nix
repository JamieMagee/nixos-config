{ pkgs, config, lib, ... }: {
  home-manager.users.jamie.home.packages = with pkgs;
  [
    coreutils
    moreutils
    dateutils
    bc
    python38Packages.glances
    nnn
    lsof
    units
    lastpass-cli
    git
    niv
    nixfmt
  ];
}