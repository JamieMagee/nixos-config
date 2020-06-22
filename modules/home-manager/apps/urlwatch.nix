{ pkgs, config, ... }: {

  home-manager.users.jamie = {
    home.packages = with pkgs; [ urlwatch ];
    systemd.user = {
      services = {
        urlwatch = {
          Unit = { Description = "Watch selected URLs for changes"; };
          Service = { ExecStart = "${pkgs.urlwatch}"; };
        };
      };
      timers = {
        urlwatch = {
          Unit = {
            Description = "Periodically watch selected URLs for changes";
          };
          Timer = {
            OnCalendar = "hourly";
            Persistent = true;
          };
          Install = { WantedBy = [ "timers.target" ]; };
        };
      };
    };
  };
}
