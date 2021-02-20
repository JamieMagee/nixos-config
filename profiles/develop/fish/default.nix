{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.fish;

  environment = {
    shellAliases = {
      cat = "${pkgs.bat}/bin/bat";

      df = "df -h";
      du = "du -h";

      ls = "${pkgs.exa}/bin/exa";
      l = "ls -lhg --git";
      la = "l -a";
      t = "l -T";
      ta = "la -T";

      ps = "${pkgs.procs}/bin/procs";
    };
    systemPackages = with pkgs; [
      bat
      exa
    ];
  };

  programs.fish = {
    enable = true;
  };
}