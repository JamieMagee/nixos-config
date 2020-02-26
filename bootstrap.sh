#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git

#----------------------------------------------------------------------
# NixOS Installation Script
#----------------------------------------------------------------------

set -eu

#----------------------------------------------------------------------
# DRIVE & SCRIPT VALUES
#----------------------------------------------------------------------

# Set DISK
select ENTRY in $(ls /dev/disk/by-id/); do
  DISK="/dev/disk/by-id/$ENTRY"
  echo "Installing ZFS on $ENTRY."
  break
done

# script values
MOUNTOPTS=compression=lz4,xattr=sa,acltype=posixacl

#----------------------------------------------------------------------
# Create Partitions
#----------------------------------------------------------------------

sudo sgdisk --zap-all "$DISK"

sudo sgdisk --clear \
  --new=1:0:+512MiB --typecode=1:ef00 --change-name=1:EFI \
  --new=2:0:0 --typecode=2:bf00 --change-name=2:zroot \
  "$DISK"

sleep 1 # udev race condition

#----------------------------------------------------------------------
# Format & Mount Partitions
#----------------------------------------------------------------------

# Create zpool
zpool create -f -O mountpoint=none -R /mnt zpool "$DISK-part2"

echo "Creating and mounting datasets in /mnt..."

# / (root) datasets
zfs create -o mountpoint=none -o canmount=off zpool/ROOT
zfs create -o mountpoint=legacy -o canmount=on zpool/ROOT/nixos
mount -t zfs zpool/ROOT/nixos /mnt
zpool set bootfs=zpool/ROOT/nixos zpool

# EFI
mkfs.fat -F32 -n EFI "$DISK-part1"
mkdir /mnt/boot
mount "$DISK-part1" /mnt/boot

# mount /nix outside of the root dataset
zfs create -o mountpoint=none -o canmount=off zpool/NIX
zfs create -o mountpoint=legacy -o canmount=on zpool/NIX/nix
mkdir /mnt/nix
mount -t zfs zpool/NIX/nix /mnt/nix

# /home dataset
zfs create -o mountpoint=none -o canmount=off zpool/HOME
zfs create -o mountpoint=legacy -o canmount=on zpool/HOME/home
mkdir /mnt/home
mount -t zfs zpool/HOME/home /mnt/home

nixos-generate-config --root /mnt

# Clone nixos-configuration repo
mkdir -p /mnt/home/jamie/code
echo "import /home/jamie/code/nixos-configuration \"$(hostname)\"" >/mnt/etc/nixos/configuration.nix
cd /mnt/home/jamie/code
git clone git://github.com/JamieMagee/nixos-configuration
cd nixos-configuration

mv /mnt/etc/nixos/hardware-configuration.nix "hardware-configuration/$(hostname).nix"

mkdir /home/jamie
mount --rbind /mnt/home/jamie /home/jamie
mount --rbind /mnt/etc/nixos /etc/nixos
umount -l /nix/.rw-store
cp /nix/ /mnt -r
mount --rbind /mnt/nix /nix

./build
nixos-install --system ./result
cd /mnt/home/jamie
chown -R 1000:1000 .
