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
      libx11
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxcb
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

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    wine
    winetricks
    bottles
    inputs.winapps.packages.${pkgs.stdenv.hostPlatform.system}.winapps
  ];
}
