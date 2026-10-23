{ ... }:

{
  # suspend was disabled together with the navi 31 display fixes (see boot.nix)
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
  '';

  # usb devices dropped out with autosuspend enabled
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
}
