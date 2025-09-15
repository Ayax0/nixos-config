{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs.java = {
    enable = true;
    package = pkgs.temurin-jre-bin;
  };

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    JAVA_OPTS = "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true";

    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    WEBKIT_DISABLE_DMABUF_RENDERER = "1";
    WEBKIT_DISABLE_TBS = "1";
  };

  environment.systemPackages = with pkgs; [
    temurin-jre-bin
    temurin-jre-bin-17
    modrinth-app
  ];
}
