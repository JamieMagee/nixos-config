{ pkgs, config, ... }: {

  home-manager.users.jamie.programs.bash = {
    enable = true;
    bashrcExtra = ''
      PARENT_COMMAND="$(ps -o comm= $PPID)"

      # Drop into fish shell
      if [ -t 1 ] && ! [[ "$PARENT_COMMAND" =~ ^(fish)$ ]]; then
          exec fish
      fi
    '';
  };

}
