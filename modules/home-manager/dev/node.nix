{ pkgs, config, ... }: {

  home-manager.users.jamie.home.packages = with pkgs; [ nodejs-13_x yarn ];

}
