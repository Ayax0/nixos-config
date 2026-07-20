{
  config,
  pkgs,
  inputs,
  system,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/ai.nix
    ./modules/apps.nix
    ./modules/audio.nix
    ./modules/development.nix
    ./modules/docker.nix
    ./modules/gaming.nix
    ./modules/geo.nix
    ./modules/graphics.nix
    ./modules/hyprland.nix
    ./modules/language.nix
    ./modules/login.nix
    ./modules/network.nix
    # ./modules/nfs.nix
    ./modules/utils.nix
    ./modules/vpn.nix
    ./modules/winapps.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "usbcore.autosuspend=-1"
    "mem_sleep_default=s2idle"
  ];
  boot.consoleLogLevel = 7;

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

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
  '';

  networking.hostName = "nixos";

  users.users.ayax0 = {
    isNormalUser = true;
    description = "Simon Gander";
    extraGroups = [
      "networkmanager"
      "seat"
      "wheel"
      "docker"
      "lp"
      "wireshark"
      "dialout"
    ];
  };

  time.timeZone = "Europe/Zurich";

  environment.systemPackages = with pkgs; [
    home-manager
    kitty
    git
  ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  programs.dconf.enable = true;

  services.dbus.enable = true;
  services.udisks2.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libusb1
    glib
    nss
    nspr
    atk
    cups
    dbus
    libdrm
    gtk3
    pango
    cairo
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    mesa
    libgbm
    expat
    alsa-lib
    at-spi2-atk
    libxkbcommon
    libGL
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.flatpak.enable = true;

  system.stateVersion = "25.11";
}
