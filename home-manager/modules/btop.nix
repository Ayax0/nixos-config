{ ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Dracula.theme";
    };
  };

  xdg.configFile."btop/themes/Dracula.theme".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/aristocratos/btop/refs/heads/main/themes/dracula.theme";
    sha256 = "14jjl13nkxppdxqir8dcw44w3vgigmwr6hs67cmqx0mbi9x7lpya";
  };
}
