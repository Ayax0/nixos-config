{ pkgs, inputs, system, ... }:
let
  unstablePkgs = import inputs.unstable {
    system = system;
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
    unstablePkgs.rustdesk
    google-chrome

    teams-for-linux
    davinci-resolve
    teleport_18
    obs-studio
    filezilla
    gimp3
    vlc
  ];
}