#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git

set -euo pipefail

prompt1="Enter your option: "
MOUNTPOINT="/mnt"
MOUNTOPTS=defaults,x-mount.mkdir
BTRFSOPTS=$MOUNTOPTS,ssd,noatime,nodiratime,discard,compress-force=zstd

contains_element() {
  #check if an element exist in a string
  for e in "${@:2}"; do [[ $e == "$1" ]] && break; done
}

select_device() {
  select ENTRY in $(ls /dev/disk/by-id/); do
    DISK="/dev/disk/by-id/$ENTRY"
    echo "Installing BTRFS on $ENTRY."
    break
  done
}

create_partition() {
  sudo sgdisk --zap-all "$DISK"

  sudo sgdisk --mbrtogpt --clear \
    --new=1:0:+512MiB --typecode=1:ef00 --change-name=1:EFI \
    --new=2:0:0 --typecode=2:8300 --change-name=2:system \
    "$DISK"

  # udev race condition
  sleep 1
}

format_partition() {
  echo "Creating and mounting datasets in /mnt..."

  # EFI
  mkfs.fat -F32 -n EFI "$DISK-part1"

  # BTRFS
  mkfs.btrfs --force --label system "$DISK-part2"

  # mount btrfs top-level subvolume for further subvolume creation
  mount -t btrfs -o $BTRFSOPTS LABEL=system /mnt
  btrfs subvolume create /mnt/root
  btrfs subvolume create /mnt/nix
  btrfs subvolume create /mnt/home
  umount -R /mnt

  # remount subvolumes
  mount -t btrfs -o $BTRFSOPTS,subvol=root LABEL=system /mnt
  mount -t btrfs -o $BTRFSOPTS,subvol=nix LABEL=system /mnt/nix
  mount -t btrfs -o $BTRFSOPTS,subvol=home LABEL=system /mnt/home

  # mount EFI
  mount -o $MOUNTOPTS "$DISK-part1" /mnt/boot
}

nixos_install() {
  nixos-generate-config --root ${MOUNTPOINT}
  nano ${MOUNTPOINT}/etc/nixos/configuration.nix
  nixos-install

  git clone https://github.com/JamieMagee/nixos-config ${MOUNTPOINT}/etc/nixos/

  reboot
}

# INSTALLATION
select_device
create_partition
format_partition
nixos_install
