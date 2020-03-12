{ pkgs, lib, config, ... }: {

  home-manager.users.jamie.programs.vscode = {
    enable = true;
    extensions =  pkgs.vscode-extensions;
  };

}