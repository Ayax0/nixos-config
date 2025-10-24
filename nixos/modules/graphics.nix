{ config, pkgs, lib, ... }:

{
  boot.kernelParams = [
    "nvidia.NVreg_DeviceFileUID=0"
    "nvidia.NVreg_DeviceFileGID=0"
    "nvidia.NVreg_DeviceFileMode=0666"
    "nvidia.NVreg_UsePageAttributeTable=1"
    "nvidia.NVreg_EnableMSI=1"
    "nvidia-drm.modeset=1"
    "video=efifb:off"
    "boot_vga=0000:17:00.0"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [
    egl-wayland
    glxinfo
  ];
}
