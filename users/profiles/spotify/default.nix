{ pkgs, ... }:
let inherit (builtins) readFile;
in {
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "Jammie001";
        password = "${readFile ../../../secrets/spotifyd}";
      };
    };
  };
  home.packages = with pkgs; [ spotify-tui ];
  xdg.configFile."spotify-tui/client.yml".source = ../../../secrets/spotify-tui;
}
