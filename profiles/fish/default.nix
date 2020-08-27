{ lib, pkgs, ... }: {
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;

    promptInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';

    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

      eval (${pkgs.direnv}/bin/direnv hook fish)
    '';
  };
}
