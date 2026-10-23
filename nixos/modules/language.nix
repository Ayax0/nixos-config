{ lib, ... }:

let
  c = import ../../catppuccin.nix;
in
{
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_CH.UTF-8";
    LC_IDENTIFICATION = "de_CH.UTF-8";
    LC_MEASUREMENT = "de_CH.UTF-8";
    LC_MONETARY = "de_CH.UTF-8";
    LC_NAME = "de_CH.UTF-8";
    LC_NUMERIC = "de_CH.UTF-8";
    LC_PAPER = "de_CH.UTF-8";
    LC_TELEPHONE = "de_CH.UTF-8";
    LC_TIME = "de_CH.UTF-8";
  };

  services.xserver.xkb = {
    layout = "ch";
    variant = "de_nodeadkeys";
  };

  console.useXkbConfig = true;
  console.colors = map (lib.removePrefix "#") (
    with c;
    [
      base
      red
      green
      yellow
      blue
      pink
      teal
      subtext1
      surface2
      red
      green
      yellow
      blue
      pink
      teal
      subtext0
    ]
  );
}
