{ config, pkgs, ... }:

{
  imports = [
    ../modules/home-manager/hyprcursor.nix
    ../modules/home-manager/hyprland.nix
    ../modules/home-manager/hyprlock.nix
    ../modules/home-manager/hyprpaper.nix
    ../modules/home-manager/kitty.nix
    ../modules/home-manager/rofi-theme.nix
    ../modules/home-manager/rofi.nix
    ../modules/home-manager/theme.nix
    ../modules/home-manager/waybar.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home = {
    username = "ayax0";
    homeDirectory = "/home/ayax0";
  };

  programs.git = {
    enable = true;
    userName = "Simon Gander";
    userEmail = "sg@vtt.ch";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.nautilus}/bin/nautilus";
      };
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
