{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gdal
  ];
}
