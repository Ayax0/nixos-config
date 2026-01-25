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
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.neovim.packages.${system}.default
    jetbrains.datagrip
    platformio
    avrdude
    vscode
    bruno

    nodejs_24
    pnpm

    gcc
    gnumake
    python314
    sonarlint-ls
    mongodb-compass
    nixfmt-rfc-style
  ];

  services.udev.packages = with pkgs; [
    platformio-core.udev
    openocd
  ];
}
