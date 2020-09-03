{pkgs, ...}:{
  security.chromiumSuidSandbox.enable = true;
  environment.systemPackages = with pkgs; [
    chromium
  ];
}