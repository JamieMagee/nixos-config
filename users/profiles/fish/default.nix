{ pkgs, ... }: {
  home.packages = with pkgs; [ freerdp ];
  xdg.configFile."fish/functions".source = ./functions;
}
