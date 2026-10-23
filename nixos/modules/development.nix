{ pkgs, inputs, ... }:

{
  # global jdk; other versions per project via devShell
  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };

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
