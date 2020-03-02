{ pkgs, config, ... }: {

  environment.sessionVariables.SHELL = "fish";
  home-manager.users.jamie.programs.fish = {
    enable = true;
  };
}