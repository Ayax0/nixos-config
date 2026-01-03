{ pkgs, ... }:

{
  fileSystems."/mnt/postgis" = {
    device = "10.10.10.85:/mnt/docker/sg";
    fsType = "nfs";
  };

  boot.supportedFilesystems = [ "nfs" ];
}
