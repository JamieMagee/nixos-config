device:
{ pkgs, lib, ... }: {
  imports = [
    ./applications/packages.nix
    ./applications/vscode.nix
    ./workspace/fish.nix
    ./workspace/git.nix
    # ./workspace/sway.nix
    ./workspace/gnome.nix
    ./applications/dotnet.nix
    ./devices.nix
    ./hardware.nix
    ./network.nix
    ./packages.nix
    ./ssh.nix
    ./users.nix
    ./dns.nix
  ];
}