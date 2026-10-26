{
  config,
  lib,
  pkgs,
  ...
}:

let
  # private key stays out of the nix store; created once, like an ssh host key
  key = "${config.xdg.configHome}/wayvnc/rsa_key.pem";
  inherit (config.wayland.windowManager.hyprland.settings) input;
in
{
  # vnc server for the hyprland desktop, reachable over tailscale only (nixos/modules/remote.nix)
  services.wayvnc = {
    enable = true;
    autoStart = true;
    # 26.05 ships neatvnc 1.0.0: tigervnc freezes once it enables continuous updates
    # (any1/neatvnc#185, fixed in 1.0.2) and output-set stops capturing (any1/wayvnc#452,
    # fixed in 0.10.2); back to stable once it ships these versions
    package = pkgs.unstable.wayvnc;
    settings = {
      address = "0.0.0.0";
      port = 5900;
      # log in with the account password, session encrypted with RSA-AES
      enable_auth = true;
      enable_pam = true;
      rsa_private_key_file = key;
      # the virtual keyboard defaults to us, which has no keys for ä, ö, ü and the like
      xkb_layout = input.kb_layout;
      xkb_variant = input.kb_variant;
    };
  };

  # wayvnc captures the first output it sees (HDMI-A-2 on the second gpu) and the
  # module has no option for arguments: pin the main screen
  systemd.user.services.wayvnc.Service.ExecStart = lib.mkForce [
    "${lib.getExe config.services.wayvnc.package} --output=DP-1"
  ];

  # a crash would otherwise lock out remote access until the next login
  systemd.user.services.wayvnc.Service.Restart = "on-failure";

  systemd.user.services.wayvnc.Service.ExecStartPre = "${pkgs.writeShellScript "wayvnc-key" ''
    [ -f ${key} ] || ${pkgs.openssh}/bin/ssh-keygen -q -m pem -t rsa -N "" -f ${key}
  ''}";
}
