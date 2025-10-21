{ config, pkgs, inputs, system, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  users.users.ayax0 = {
    isNormalUser = true;
    description = "Simon Gander";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  time.timeZone = "Europe/Zurich";
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    home-manager
    
    keeweb
    vscode
    google-chrome
    inputs.zen-browser.packages."${system}".default
  ];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  services.dbus.enable = true;
  services.openssh.enable = true;
  services.udisks2.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  system.stateVersion = "25.05";

}
