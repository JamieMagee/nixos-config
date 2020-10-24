{ pkgs, ... }: {
  boot.plymouth.enable = true;
  hardware.opengl.enable = true;

  services.xserver = {
    enable = true;
    displayManager = {
      gdm = {
        enable = true;
      };
    };
    desktopManager = {
      gnome3 = {
        enable = true;
      };
    };
  };
}
