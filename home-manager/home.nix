{ config, pkgs, ... }:

{
  home = {
    username = "ayax0";
    homeDirectory = "/home/ayax0";
    stateVersion = "25.05";
  };

  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
    ];

    sessionVariables = {};
  };

  imports = [
    ./modules/git.nix
    ./modules/hyprcursor.nix
    ./modules/hyprland.nix
    ./modules/hyprlock.nix
    ./modules/kitty.nix
    ./modules/nautilus.nix
    ./modules/rofi.nix
    # ./modules/mpvpaper.nix
    ./modules/waybar.nix
  ];

  fonts = {
    fontconfig = {
      enable = true;

      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        serif = [ "Noto Serif" "Noto Color Emoji" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      };
    };
  };

  programs.home-manager.enable = true;
}
