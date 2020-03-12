{ pkgs, lib, ... }: {
  imports = [
    ./packages.nix
    ./apps/fish.nix
    ./apps/vscode.nix
    ./dev/dotnet.nix
    ./dev/git.nix
    ./workspaces/gnome.nix
  ];
}