{ pkgs, ... }:

{
  programs.btop = {
    enable = true;
    package = pkgs.btop.override { rocmSupport = true; };
    settings.color_theme = "dracula";
  };
}
