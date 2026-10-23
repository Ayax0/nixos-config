{ pkgs, ... }:

{
  # the only global jdk
  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };

  # loads a project's .envrc, e.g. `use flake ~/nixos-config#node22`
  programs.direnv.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  environment.systemPackages = with pkgs; [
    neovim
    jetbrains.datagrip
    platformio
    avrdude
    unstable.vscode
    claude-code
    bruno
    mqtt-explorer
    mongodb-compass
    nixfmt

    # global, not per project: claude code hooks run node and python3, mcp servers
    # start via npx, node-gyp needs gcc and make
    nodejs_24
    pnpm
    python314
    uv
    gcc
    gnumake
  ];

  services.udev.packages = with pkgs; [
    platformio-core.udev
    openocd
  ];
}
