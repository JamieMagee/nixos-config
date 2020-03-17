{ pkgs, config, lib, ... }: {
  home-manager.users.jamie.home.packages = with pkgs;
  [
    coreutils
    moreutils
    dateutils
    bc
    glances
    nnn
    lsof
    units
    lastpass-cli
    git
    niv
    nixfmt
    fd
  ];
}