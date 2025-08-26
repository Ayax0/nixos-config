{ config, pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  
  services.xserver.videoDrivers = [ "nvidia" ];
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  hardware.graphics.enable = true;
  
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk 
    ];
  };

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_NO_ATOMIC = "1";
    WLR_RENDERER = "vulkan";
  };

  # Electron/Chromium-Apps standardmäßig Wayland nutzen
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GBM_BACKEND = "nvidia-drm";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Client-Tools in PATH:
  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    hyprcursor
    hyprlock
    waybar
    rofi
    kitty
    nautilus
    catppuccin-cursors.mochaMauve
    libsForQt5.qt5ct
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
