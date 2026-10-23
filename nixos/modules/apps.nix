{ pkgs, inputs, ... }:

{
  # Art-Net for qlcplus and xlights
  networking.firewall.allowedUDPPorts = [ 6454 ];

  environment.systemPackages = with pkgs; [
    (inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
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
    unstable.prusa-slicer
    unstable.rpi-imager
    unstable.qlcplus
    unstable.xlights
    # unstable.rustdesk-flutter
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
