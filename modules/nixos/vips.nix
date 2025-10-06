{
  config,
  unstable,
  pkgs,
  system,
  ...
}:
let
  vipsUnstable = unstable.legacyPackages.${system}.vips;
  lib = pkgs.lib;
in
{
  environment.systemPackages = with pkgs; [
    vipsUnstable
    glib
    glib.dev
    pkg-config
  ];

  environment.sessionVariables = {
    PKG_CONFIG_PATH = lib.concatStringsSep ":" [
      "${vipsUnstable.dev}/lib/pkgconfig"
      "${pkgs.glib.dev}/lib/pkgconfig"
      "${vipsUnstable}/lib/pkgconfig"
      "${pkgs.glib}/lib/pkgconfig"
    ];
  };
}
