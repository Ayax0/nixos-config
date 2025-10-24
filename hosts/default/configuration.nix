{ config, pkgs, inputs, system, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  users.users.ayax0 = {
    isNormalUser = true;
    description = "Simon Gander";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  time.timeZone = "Europe/Zurich";

  environment.systemPackages = with pkgs; [
    home-manager
    
    ffmpeg
    keeweb
    vscode
    google-chrome
    inputs.zen-browser.packages."${system}".default

    nodejs_22
    pnpm
  ];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  services.dbus.enable = true;
  services.openssh.enable = true;
  services.udisks2.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.udev.extraRules = ''
    KERNEL=="card*", KERNELS=="0000:65:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-main"
    KERNEL=="card*", KERNELS=="0000:17:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-secondary"
  '';

  system.stateVersion = "25.05";

}
