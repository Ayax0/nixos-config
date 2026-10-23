{ ... }:

{
  home.stateVersion = "25.05";

  imports = [
    ./modules/btop.nix
    ./modules/git.nix
    ./modules/hyprcursor.nix
    ./modules/hyprland.nix
    ./modules/hyprlock.nix
    ./modules/hyprpaper.nix
    ./modules/keepassxc.nix
    ./modules/kitty.nix
    ./modules/nautilus.nix
    ./modules/rofi.nix
    ./modules/ssh.nix
    ./modules/swaync.nix
    ./modules/themes.nix
    ./modules/waybar.nix
    ./modules/wlogout.nix
  ];
}
