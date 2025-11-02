{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.temurin-jre-bin;
  };

  environment.systemPackages = with pkgs; [
    temurin-jre-bin
    temurin-jre-bin-17
    modrinth-app
    prismlauncher
  ];
}
