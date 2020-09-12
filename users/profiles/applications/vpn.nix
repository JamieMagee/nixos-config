{ pkgs, ... }:
{
  home.packages = with pkgs; [
    msvpn
  ];
}