device:
{ pkgs, lib, ... }: {
  imports = [
    ./devices.nix
    ./users.nix
    ./network.nix
    ./hardware.nix
    ./ssh.nix
  ];
}