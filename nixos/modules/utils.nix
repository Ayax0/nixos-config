{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    unzip
    ffmpeg
    ripgrep
  ];
}