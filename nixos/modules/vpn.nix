{ pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
      networkmanager_strongswan
    ];
  };

  environment.systemPackages = with pkgs; [
    networkmanager-l2tp
    networkmanager_strongswan
  ];
}
