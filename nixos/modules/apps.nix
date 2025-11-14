{
  pkgs,
  inputs,
  system,
  ...
}:
let
  unstablePkgs = import inputs.unstable {
    system = system;
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
    unstablePkgs.prusa-slicer
    unstablePkgs.rustdesk
    google-chrome

    teams-for-linux
    davinci-resolve
    teleport_18
    obs-studio
    filezilla
    onedrive
    obsidian
    gimp3
    qgis
    vlc
  ];
}
