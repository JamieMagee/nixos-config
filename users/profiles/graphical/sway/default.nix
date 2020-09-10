{pkgs, ...}:{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      bars = [{
        command = "${pkgs.waybar}/bin/waybar";
      }];
    };
    systemdIntegration = true;
    wrapperFeatures.gtk = true;
  };
}