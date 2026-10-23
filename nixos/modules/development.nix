{ pkgs, inputs, ... }:

{
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  environment.systemPackages = with pkgs; [
    inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.default
    jetbrains.datagrip
    platformio
    avrdude
    unstable.vscode
    claude-code
    bruno

    jdk21
    jdk25

    nodejs_24
    pnpm

    uv
    gcc
    pipx
    gnumake
    python314
    mqtt-explorer
    mongodb-compass
    nixfmt-rfc-style
  ];

  services.udev.packages = with pkgs; [
    platformio-core.udev
    openocd
  ];
}
