{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs.java = {
    enable = true;
    package = pkgs.temurin-jre-bin;
  };

  environment.sessionVariables = {
    WEBKIT_DISABLE_DMABUF_RENDERER = "1 ModrinthApp";
  };

  environment.systemPackages = with pkgs; [
    temurin-jre-bin
    temurin-jre-bin-17
    modrinth-app
  ];
}
