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
    (inputs.zen-browser.packages.${system}.default.override {
      extraPolicies = {
        Preferences = {
          # limit content processes; 2026-07-07 OOM: 32 content processes x ~1.1GB ate 30GB
          "dom.ipc.processCount" = {
            Value = 4;
            Status = "locked";
          };
          "dom.ipc.processCount.webIsolated" = {
            Value = 1;
            Status = "locked";
          };
        };
      };
    })
    unstablePkgs.prusa-slicer
    unstablePkgs.rpi-imager
    unstablePkgs.qlcplus
    unstablePkgs.xlights
    # unstablePkgs.rustdesk-flutter
    google-chrome

    teams-for-linux
    davinci-resolve
    freecad-wayland
    plex-desktop
    teleport_18
    obs-studio
    filezilla
    inkscape
    onedrive
    obsidian
    audacity
    discord
    gparted
    gimp3
    kicad
    vlc

    wine
    winetricks
    bottles
  ];
}
