{ pkgs, lib, ... }: {
  imports = [
    ./packages.nix
    ./apps/bash.nix
    ./apps/fish.nix
    ./apps/urlwatch.nix
    ./apps/vscode.nix
    ./dev/dotnet.nix
    ./dev/python.nix
    ./dev/node.nix
    ./dev/git.nix
    ./workspaces/gnome.nix
  ];
}
