{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    discord
    signal-desktop
    teams
    slack
  ];
}
