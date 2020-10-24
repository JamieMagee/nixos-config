{ config, lib, pkgs, ... }:
let 
  inherit (lib) fileContents;
in {
  users.users = {
    rclone = {
      group = "rclone";
      isSystemUser = true;
    };
  };

  users.groups.rclone = { };

  security.wrappers = {
    fusermount = {
      source = "${pkgs.fuse}/bin/fusermount";
      setuid = true;
      setgid = false;
    };
  };

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  environment.etc."rclone/rclone.conf" = {
    text = fileContents ../secrets/rclone;
    user = "rclone";
    group = "rclone";
  };

  systemd.services.rclone-init = {
    script = ''
      ${pkgs.coreutils}/bin/mkdir -p /mnt/rclone
      ${pkgs.coreutils}/bin/chown rclone:rclone /mnt/rclone
      ${pkgs.coreutils}/bin/chown -R rclone:rclone /etc/rclone/
    '';
    serviceConfig = { Type = "oneshot"; };
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.rclone-mount = {
    description = "rclone";
    after = [ "rclone-init.service" ];
    wantedBy = [ "multi-user.target" ];
    path = [ "${config.security.wrapperDir}/.." ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
          --config /etc/rclone/rclone.conf \
          --allow-other \
          --buffer-size 256M \
          --dir-cache-time 72h \
          --vfs-read-chunk-size 8M \
          --vfs-cache-mode writes \
          --vfs-cache-max-size 4G \
          --vfs-cache-max-age 6h \
          gdrive: /mnt/rclone
      '';
      ExecStop = "${config.security.wrapperDir}/fusermount -uz /mnt/rclone";
      Type = "notify";
      Restart = "always";
      RestartSec = 30;
      StartLimitInterval = 200;
      StartLimitBurst = 5;
      User = "rclone";
      Group = "rclone";
    };
  };

}
