{ pkgs, ... }:

{
  boot = {
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    loader.efi.canTouchEfiVariables = true;

    # rx 7900 (navi 31) lost all displays on 6.12 with dcn32 REG_WAIT timeouts;
    # newer kernels carry the dcn 3.2 fixes and run stable here since 2026-09
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [ "boot.shell_on_fail" ];
  };
}
