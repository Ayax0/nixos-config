{ pkgs, ... }:

{
  xdg.desktopEntries.keeweb = {
    name = "KeeWeb";
    comment = "Password manager compatible with KeePass databases";
    exec = "keeweb --no-sandbox";
    icon = "keeweb";
    terminal = false;
    categories = [ "Utility" "Security" ];
  };

  home.packages = with pkgs; [ keeweb ];
}