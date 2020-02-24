#!/usr/bin/env bash

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

read -p "> Do you want to securely wipe $ENTRY ?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sgdisk --zap-all /dev/device
  cryptsetup open --type plain /dev/device container --key-file /dev/random
  dd if=/dev/zero of=/dev/mapper/container status=progress
  cryptsetup close container
fi

#----------------------------------------------------------------------
# Create Partitions
#----------------------------------------------------------------------

sgdisk --zap-all "$DISK"

sgdisk --clear \
  --new=1:0:+512MiB --typecode=1:ef00 --change-name=1:EFI \
  --new=2:0:0 --typecode=2:bf00 --change-name=2:zroot \
  "$DISK"

sleep 1 # udev race condition

#----------------------------------------------------------------------
# Format & Mount Partitions
#----------------------------------------------------------------------

# EFI
mkfs.fat -F32 -n EFI "$DISK-part1"

# Create zpool
zpool create -O mountpoint=none -R /mnt zpool "$DISK-part2"

zfs create -o mountpoint=legacy zpool/root
zfs create -o mountpoint=legacy zpool/home

mount -t zfs zpool/root /mnt

mkdir /mnt/boot
mount "$DISK-part1" /mnt/boot
mkdir /mnt/home
mount -t zfs zpool/home /mnt/home

nixos-generate-config --root /mnt
