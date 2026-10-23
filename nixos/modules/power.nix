{ ... }:

{
  # the navi 31 display controller hung when waking from sleep (see boot.nix)
  systemd.sleep.settings.Sleep = {
    AllowSuspend = false;
    AllowHibernation = false;
    AllowSuspendThenHibernate = false;
    AllowHybridSleep = false;
  };

  # usb devices dropped out with autosuspend enabled
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
}
