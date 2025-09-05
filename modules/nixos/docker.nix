{ config, pkgs, ... }:
{
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    daemon.settings = {
      "insecure-registries" = [ "registry.nlu-office.ch" ];
    };
  };

  environment.etc."buildkit/buildkitd.toml".text = ''
    [registry."registry.nlu-office.ch"]
      http = true        # falls reine HTTP-Registry
      insecure = true    # bei selbstsigniertem Zertifikat (HTTPS) oder HTTP
  '';

  # (optional) Benutzer zur docker-Gruppe hinzufügen:
  users.users.ayax0.extraGroups = [ "docker" ];

  # Client-Tools in PATH:
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
}
