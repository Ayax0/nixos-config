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
    unstablePkgs.rpi-imager
    unstablePkgs.rustdesk
    google-chrome

    teams-for-linux
    davinci-resolve
    freecad-wayland
    teleport_18
    obs-studio
    filezilla
    onedrive
    obsidian
    gparted
    gimp3
    vlc
  ];
}
