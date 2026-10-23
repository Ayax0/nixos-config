{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/ai.nix
    ./modules/apps.nix
    ./modules/audio.nix
    ./modules/boot.nix
    ./modules/compat.nix
    ./modules/development.nix
    ./modules/docker.nix
    ./modules/gaming.nix
    ./modules/geo.nix
    ./modules/graphics.nix
    ./modules/hyprland.nix
    ./modules/language.nix
    ./modules/login.nix
    ./modules/memory.nix
    ./modules/network.nix
    ./modules/power.nix
    ./modules/printing.nix
    ./modules/remote.nix
    ./modules/storage.nix
    ./modules/utils.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: _: {
      unstable = import inputs.unstable {
        inherit (final.stdenv.hostPlatform) system;
        config.allowUnfree = true;
      };
    })
  ];

  networking.hostName = "nixos";
  time.timeZone = "Europe/Zurich";

  users.users.ayax0 = {
    isNormalUser = true;
    description = "Simon Gander";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "lp"
      "wireshark"
      "dialout"
    ];
  };

  environment.systemPackages = with pkgs; [ git ];

  system.stateVersion = "25.11";
}
