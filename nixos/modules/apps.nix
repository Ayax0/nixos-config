{ pkgs, inputs, system, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    google-chrome

    teams-for-linux
    davinci-resolve
    teleport_18
    filezilla
    rustdesk
    gimp3
    vlc
  ];
}