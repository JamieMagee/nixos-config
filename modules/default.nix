device:
{ pkgs, lib, ... }: {
  imports = [
    ./applications/packages.nix
    ./applications/virtualbox.nix
    ./applications/vscode.nix
    ./workspace/fish.nix
    # ./workspace/sway.nix
    ./workspace/gnome.nix
    ./devices.nix
    ./hardware.nix
    ./network.nix
    ./packages.nix
    ./ssh.nix
    ./users.nix
  ];
}