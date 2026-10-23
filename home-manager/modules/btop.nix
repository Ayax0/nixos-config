{ pkgs, ... }:

let
  c = import ../../catppuccin.nix;
  theme = "catppuccin_${c.flavor}.theme";
  ports = pkgs.catppuccin.override {
    variant = c.flavor;
    inherit (c) accent;
    themeList = [ "btop" ];
  };
in
{
  programs.btop = {
    enable = true;
    package = pkgs.btop.override { rocmSupport = true; };
    settings.color_theme = theme;
  };

  xdg.configFile."btop/themes/${theme}".source = "${ports}/btop/${theme}";
}
