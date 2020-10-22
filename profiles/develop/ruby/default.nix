{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ jetbrains.ruby-mine ];
}
