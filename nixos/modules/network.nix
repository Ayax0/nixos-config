{ pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
      networkmanager_strongswan
    ];
  };

  environment.etc."strongswan.conf".text = "";

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanager-l2tp
    networkmanager_strongswan
  ];
}