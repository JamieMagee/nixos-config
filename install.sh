#!/usr/bin/env bash

#----------------------------------------------------------------------
# NixOS Installation Script
#----------------------------------------------------------------------

set -eu

#----------------------------------------------------------------------
# DRIVE & SCRIPT VALUES
#----------------------------------------------------------------------

# ls /dev/disk/by-id/
DISK=/dev/disk/by-id/...

# script values
HOST=deadbeef # this will get changed later by ansible anyway
USER=jamie
MOUNT=/mnt
MOUNTOPTS=defaults,x-mount.mkdir
BTRFSOPTS=$MOUNTOPTS,ssd,noatime,nodiratime,discard,compress-force=zstd

#----------------------------------------------------------------------
# preflight cleanup
#----------------------------------------------------------------------

[ -n "${SWAP:=$(swapon --noheadings --show=NAME)}" ] && swapoff $SWAP
umount /mnt/boot || :
umount -R /mnt || :

#----------------------------------------------------------------------
# optional: secure wipe of disk (takes a while)
#----------------------------------------------------------------------

# sgdisk --zap-all /dev/device
# cryptsetup open --type plain /dev/device container --key-file /dev/random
# dd if=/dev/zero of=/dev/mapper/container status=progress
# cryptsetup close container

#----------------------------------------------------------------------
# Create Partitions
#----------------------------------------------------------------------

# NOTE: EFI partition should be at least 550MiB according to
# http://www.rodsbooks.com/efi-bootloaders/principles.html

sgdisk --zap-all $DISK

sgdisk --clear \
  --new=1:0:+512MiB --typecode=1:ef00 --change-name=1:EFI \
  --new=2:0:0 --typecode=2:bf00 --change-name=2:zroot \
  $DISK

sleep 1 # udev race condition

#----------------------------------------------------------------------
# Format & Mount Partitions
#----------------------------------------------------------------------

mkfs.fat -F32 -n EFI $DISK-part1

zpool create -O mountpoint=none -R /mnt zpool $DISK-part2

zfs create -o mountpoint=legacy zpool/root
zfs create -o mountpoint=legacy zpool/home

mount -t zfs zpool/root /mnt

mkdir /mnt/boot
mount $DISK-part1 /mnt/boot
mkdir /mnt/home
mount -t zfs zpool/home /mnt/home

nixos-generate-config --root /mnt
