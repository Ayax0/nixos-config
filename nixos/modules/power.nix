{ ... }:

{
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
  '';

  boot.kernelParams = [
    # usb devices dropped out with autosuspend enabled
    "usbcore.autosuspend=-1"
    "mem_sleep_default=s2idle"
  ];
}
