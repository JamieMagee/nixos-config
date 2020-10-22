{ pkgs, ... }: { environment.systemPackages = with pkgs; [ jetbrains.rider ]; }
