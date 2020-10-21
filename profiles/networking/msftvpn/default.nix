{ pkgs, ... }: { environment.systemPackages = with pkgs; [ msftvpn ]; }
