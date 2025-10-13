{
  docker = import ./docker.nix;
  hyprland = import ./hyprland.nix;
  keeweb = import ./keeweb.nix;
  gaming = import ./gaming.nix;
  httpd = import ./httpd.nix;
  obs = import ./obs.nix;
  polkit = import ./polkit.nix;
  print = import ./print.nix;
  vips = import ./vips.nix;
}
