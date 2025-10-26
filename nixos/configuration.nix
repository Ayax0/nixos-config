{ config, pkgs, inputs, system, ... }:

{
  imports = [
    ./hardware-configuration.nix
    
    ./modules/audio.nix
    ./modules/docker.nix
    ./modules/graphics.nix
    ./modules/hyprland.nix
    ./modules/language.nix
    ./modules/login.nix
    ./modules/network.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos";

  users.users.ayax0 = {
    isNormalUser = true;
    description = "Simon Gander";
    extraGroups = [ 
      "networkmanager"
      "seat" 
      "wheel"
      "docker"
    ];
  };

  time.timeZone = "Europe/Zurich";

  environment.systemPackages = with pkgs; [
    home-manager
    
    ffmpeg
    vscode
    google-chrome
    inputs.zen-browser.packages."${system}".default

    nodejs_22
    pnpm

    bruno
  ];

  programs.dconf.enable = true;  

  services.dbus.enable = true;
  services.udisks2.enable = true;
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  system.stateVersion = "25.05";

}
