{ pkgs, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      output = { Virtual-1 = { mode = "1920x1080"; }; };
      keybindings = let
        moveMouse = ''
          exec "sh -c 'eval `${pkgs.xdotool}/bin/xdotool \
                getactivewindow \
                getwindowgeometry --shell`; ${pkgs.xdotool}/bin/xdotool \
                mousemove \
                $((X+WIDTH/2)) $((Y+HEIGHT/2))'"'';
      in ({
        "${modifier}+q" = "kill";
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";

        "${modifier}+Left" = "focus child; focus left; ${moveMouse}";
        "${modifier}+Right" = "focus child; focus right; ${moveMouse}";
        "${modifier}+Up" = "focus child; focus up; ${moveMouse}";
        "${modifier}+Down" = "focus child; focus down; ${moveMouse}";
        "${modifier}+Control+Left" = "focus parent; focus left; ${moveMouse}";
        "${modifier}+Control+Right" = "focus parent; focus right; ${moveMouse}";
        "${modifier}+Control+Up" = "focus parent; focus up; ${moveMouse}";
        "${modifier}+Control+Down" = "focus parent; focus down; ${moveMouse}";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Shift+Left" = "move left";

        "${modifier}+F5" = "reload";
      });
    };
    systemdIntegration = true;
    wrapperFeatures.gtk = true;
  };
}
