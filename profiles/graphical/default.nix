{ pkgs, ... }: {
  boot.plymouth.enable = true;
  hardware.opengl.enable = true;

  services.xserver = {
    enable = true;
    displayManager = {
      sessionPackages = with pkgs; [
        sway
      ];
      lightdm = {
        enable = true;
      };
    };
  };
}
