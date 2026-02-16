{ pkgs, ... }:

{
  boot.plymouth.enable = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.xwayland.enable = true;

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
  ];
}
