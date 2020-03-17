{ pkgs, config, lib, ... }: {

    services.fwupd.enable = true;

    hardware.enableRedistributableFirmware = true;

    hardware.enableAllFirmware = true;

}