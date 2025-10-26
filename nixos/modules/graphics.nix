{ ... }:

{
  boot.plymouth.enable = true;

  hardware.graphics.enable = true;

  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  services.xserver.videoDrivers = [ "nvidia" ];

  services.udev.extraRules = ''
    KERNEL=="card*", KERNELS=="0000:65:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-main"
    KERNEL=="card*", KERNELS=="0000:17:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-secondary"
  '';

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_DEVICES = "/dev/dri/nvidia-main:/dev/dri/nvidia-secondary";
    AQ_DRM_DEVICES = "/dev/dri/nvidia-main:/dev/dri/nvidia-secondary";
  };
}
