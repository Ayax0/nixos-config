{ ... }:

{
  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };
  # high swappiness recommended for zram: prefer compressing idle anon pages
  boot.kernel.sysctl."vm.swappiness" = 180;

  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableUserSlices = true;
    settings.OOM = {
      DefaultMemoryPressureDurationSec = "20s";
    };
  };
}
