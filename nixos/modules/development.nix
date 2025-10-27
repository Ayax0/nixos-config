{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.datagrip
    neovim
    vscode
    bruno

    nodejs_22
    pnpm

    gcc
    gnumake
    python314
    nixfmt-rfc-style
  ];
}