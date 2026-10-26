{
  config,
  lib,
  pkgs,
  ...
}:

let
  # private key stays out of the nix store; created once, like an ssh host key
  key = "${config.xdg.configHome}/wayvnc/rsa_key.pem";
in
{
  # vnc server for the hyprland desktop, reachable over tailscale only (nixos/modules/remote.nix)
  services.wayvnc = {
    enable = true;
    autoStart = true;
    settings = {
      address = "0.0.0.0";
      port = 5900;
      # log in with the account password, session encrypted with RSA-AES
      enable_auth = true;
      enable_pam = true;
      rsa_private_key_file = key;
    };
  };

  # wayvnc captures the first output it sees (HDMI-A-2 on the second gpu) and the
  # module has no option for arguments: pin the main screen
  systemd.user.services.wayvnc.Service.ExecStart = lib.mkForce [
    "${lib.getExe config.services.wayvnc.package} --output=DP-1"
  ];

  systemd.user.services.wayvnc.Service.ExecStartPre = "${pkgs.writeShellScript "wayvnc-key" ''
    [ -f ${key} ] || ${pkgs.openssh}/bin/ssh-keygen -q -m pem -t rsa -N "" -f ${key}
  ''}";
}
