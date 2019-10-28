{ config, pkgs, ... }:

{
  imports = [ 
    <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
    ./users/jamie.nix
  ];


  # Let demo build as a trusted user.
  nix.trustedUsers = [ "demo" ];

# By default, the NixOS VirtualBox demo image includes SDDM and Plasma.
# If you prefer another desktop manager or display manager, you may want
# to disable the default.
# services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
# services.xserver.displayManager.sddm.enable = lib.mkForce false;

# Enable GDM/GNOME by uncommenting above two lines and two lines below.
# services.xserver.displayManager.gdm.enable = true;
# services.xserver.desktopManager.gnome3.enable = true;

# Set your time zone.
time.timeZone = "Europe/Copenhagen";

# List packages installed in system profile. To search, run:
# \$ nix search wget
# environment.systemPackages = with pkgs; [
#   wget vim
# ];

# Enable the OpenSSH daemon.
services.openssh.enable = true;

}