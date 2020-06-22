{ pkgs, config, ... }: {

  home-manager.users.jamie.home.packages = with pkgs; [ brave ];

}
