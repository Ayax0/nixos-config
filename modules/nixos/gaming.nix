{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    WEBKIT_DISABLE_DMABUF_RENDERER = "1 ModrinthApp";
  };

  environment.systemPackages = with pkgs; [
    temurin-jre-bin-17
    modrinth-app
  ];
}