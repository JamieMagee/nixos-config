device:
{ pkgs, lib, ... }: {
  imports = [ ./devices.nix ./nixos ./home-manager ];
}
