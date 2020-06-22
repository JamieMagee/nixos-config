{ pkgs, lib, config, ... }: {

  home-manager.users.jamie.home.packages = with pkgs;
    [ (python3Full.withPackages (ps: with ps; [ virtualenv pip ])) ];

}
