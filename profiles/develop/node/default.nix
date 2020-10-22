{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ nodejs-12_x jetbrains.webstorm ];
}
