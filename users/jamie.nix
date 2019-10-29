{ config, lib, pkgs, ... }:
{
  users.extraUsers = {
    jamie = {
      description = "Jamie Magee";
      uid = 1001;
      home = "/home/jamie";
      shell = pkgs.fish;
      createHome = true;
      useDefaultShell = true;
      initialPassword = "hunter2";
    };
  };
}