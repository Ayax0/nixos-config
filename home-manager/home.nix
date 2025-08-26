{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/home-manager/kitty.nix
    ../modules/home-manager/xdg.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "ayax0";
    homeDirectory = "/home/ayax0";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Simon Gander";
    userEmail = "sg@vtt.ch";
    extraConfig.init.defaultBranch = "main";
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
