{ config, pkgs, ... }:

{
  home = {
    username = "ayax0";
    homeDirectory = "/home/ayax0";
    stateVersion = "25.05";
  };

  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [];

    sessionVariables = {};
  };

  imports = [
    ./modules/git.nix
    ./modules/hyprcursor.nix
    ./modules/hyprland.nix
    ./modules/hyprlock.nix
    ./modules/keeweb.nix
    ./modules/kitty.nix
    ./modules/nautilus.nix
    ./modules/rofi.nix
    ./modules/ssh.nix
    ./modules/themes.nix
    ./modules/mpvpaper.nix
    ./modules/waybar.nix
    ./modules/wlogout.nix
  ];

  programs.home-manager.enable = true;
}
