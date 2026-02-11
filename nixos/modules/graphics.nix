{ ... }:

{
  boot.plymouth.enable = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.xwayland.enable = true;

  # services.udev.extraRules = ''
  #   KERNEL=="card*", KERNELS=="0000:65:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-main"
  #   KERNEL=="card*", KERNELS=="0000:17:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-secondary"
  # '';

  environment.variables = {
    # GBM_BACKEND = "nvidia-drm";
    # LIBVA_DRIVER_NAME = "nvidia";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_DRM_DEVICES = "/dev/dri/nvidia-main:/dev/dri/nvidia-secondary";
    # AQ_DRM_DEVICES = "/dev/dri/nvidia-main:/dev/dri/nvidia-secondary";
  };
}
