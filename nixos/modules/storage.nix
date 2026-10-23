{ ... }:

{
  boot.supportedFilesystems = [
    "ntfs"
    "exfat"
  ];

  services.udisks2.enable = true;
  # cap page cache for usb disks so copy progress matches what is actually written
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", ENV{ID_BUS}=="usb", ATTR{bdi/strict_limit}="1", ATTR{bdi/max_bytes}="33554432"
  '';
}
