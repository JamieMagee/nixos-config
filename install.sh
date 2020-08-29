#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git zfs

set -eux

prompt1="Enter your option: "
MOUNTPOINT="/mnt"

contains_element() {
  #check if an element exist in a string
  for e in "${@:2}"; do [[ $e == "$1" ]] && break; done
}

select_device() {
  select ENTRY in $(ls /dev/disk/by-id/); do
    DISK="/dev/disk/by-id/$ENTRY"
    echo "Installing ZFS on $ENTRY."
    break
  done
}

create_partition() {
  sudo sgdisk --zap-all "$DISK"

  sudo sgdisk --clear \
    --new=1:0:+512MiB --typecode=1:ef00 --change-name=1:EFI \
    --new=2:0:0 --typecode=2:bf00 --change-name=2:zroot \
    "$DISK"
}

format_partition() {
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

}

nixos_install() {
  nixos-generate-config --root ${MOUNTPOINT}
  nixos-install
  
  git clone https://github.com/JamieMagee/nixos-config ${MOUNTPOINT}/etc/nixos/

  exit 0
}

# INSTALLATION
select_device
create_partition
format_partition
nixos_install
