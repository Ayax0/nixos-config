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
  environment.systemPackages = with pkgs; [
    inputs.neovim.packages.${system}.default
    jetbrains.datagrip
    vscode
    bruno

    nodejs_24
    pnpm

    gcc
    gnumake
    python314
    sonarlint-ls
    nixfmt-rfc-style
  ];
}
