{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    htop
    unzip
    ffmpeg
    ripgrep
  ];
}
