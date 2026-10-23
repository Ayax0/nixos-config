{ pkgs, ... }:

{
  programs.steam.enable = true;

  # prismlauncher ships its own jdks (8, 17, 21, 25), modrinth-app downloads them
  environment.systemPackages = with pkgs; [
    modrinth-app
    prismlauncher
  ];
}
