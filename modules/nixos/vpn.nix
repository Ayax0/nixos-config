{ pkgs, ... }:
{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
      networkmanager_strongswan
    ];
    ensureProfiles = {
      profiles = {
        "FalleggerVPN" = {
          connection = {
            id = "FalleggerVPN";
            type = "vpn";
            autoconnect = false;
          };
          vpn = {
            service-type = "org.freedesktop.NetworkManager.l2tp";
            gateway = "81.62.180.126";
            user = "nextlvlup";
            "ipsec-enabled" = "yes";
          };
        };
      };
    };
  };

  environment.etc."strongswan.conf".text = "";

  environment.systemPackages = with pkgs; [
    networkmanager-l2tp
    networkmanager_strongswan
  ];
}
