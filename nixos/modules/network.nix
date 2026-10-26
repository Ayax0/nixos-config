{ pkgs, ... }:

{
  # L2TP/IPsec VPNs (fallegger) need IKEv1, which strongSwan >= 6.0 no longer builds by default:
  # charon logs "IKE version 1 not supported" and nm-l2tp fails with "Could not establish IPsec connection".
  nixpkgs.overlays = [
    (_: prev: {
      strongswan = prev.strongswan.overrideAttrs (old: {
        configureFlags = (old.configureFlags or [ ]) ++ [ "--enable-ikev1" ];
      });
    })
  ];

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
      networkmanager_strongswan
    ];
  };

  # charon-nm from networkmanager_strongswan refuses to start without this file
  environment.etc."strongswan.conf".text = "";

  services.openssh.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # bluetooth gui (blueman-manager)
  services.blueman.enable = true;
}
