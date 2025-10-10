# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  inputs,
  system,
  ...
}:
let
  pkgs-unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  # Enable disk management
  services.udisks2.enable = true;

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Set locale
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "de_CH.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
      LC_TIME = "de_CH.UTF-8";
      LC_NUMERIC = "de_CH.UTF-8";
      LC_MONETARY = "de_CH.UTF-8";
      LC_MEASUREMENT = "de_CH.UTF-8";
      LC_PAPER = "de_CH.UTF-8";
      LC_NAME = "de_CH.UTF-8";
      LC_ADDRESS = "de_CH.UTF-8";
      LC_TELEPHONE = "de_CH.UTF-8";
      LC_IDENTIFICATION = "de_CH.UTF-8";

      LC_COLLATE = "en_US.UTF-8";
    };
  };

  # Define a user account.
  users.users.ayax0 = {
    isNormalUser = true;
    description = "Ayax0";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Packages
  environment.systemPackages = with pkgs; [
    wget
    gcc
    git
    unzip
    htop
    ripgrep
    ffmpeg
    vivaldi-ffmpeg-codecs
    libsecret
    seahorse
    sqlite
    gparted
    insomnia
    jetbrains.datagrip
    jetbrains.idea-community
    rustdesk-flutter
    vlc
    filezilla
    azure-cli

    gnumake
    python314
    nodejs_22
    pnpm
    nixfmt-rfc-style

    google-chrome
    inputs.zen-browser.packages."${system}".default
    inputs.home-manager.packages."${system}".home-manager
    vscode
    neovim
    postman
    teams-for-linux
    figma-linux
    discord
    mqtt-explorer
    rpi-imager
    davinci-resolve
    gimp3
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
