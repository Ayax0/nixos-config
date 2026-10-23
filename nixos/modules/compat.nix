{ pkgs, inputs, ... }:

# running software that is not built for NixOS
{
  # libraries for prebuilt electron apps and libusb tools
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
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
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    appimage-run
    fuse

    wine
    winetricks
    bottles
    inputs.winapps.packages.${pkgs.stdenv.hostPlatform.system}.winapps
  ];
}
