device:
{ pkgs, lib, ... }: {
  imports = [
    ./users.nix
    ./network.nix
    ./hardware.nix
  ];
}