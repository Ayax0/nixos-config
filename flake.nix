{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ayax0 = ./home-manager/home.nix;
            };
          }
        ];
      };

      # node versions per project, like nvm: `use flake ~/nixos-config#node22` in its .envrc
      devShells.x86_64-linux =
        let
          inherit (self.nixosConfigurations.nixos) pkgs;
        in
        {
          node22 = pkgs.mkShell { packages = [ pkgs.nodejs_22 ]; };
          node24 = pkgs.mkShell { packages = [ pkgs.nodejs_24 ]; };
          node26 = pkgs.mkShell { packages = [ pkgs.nodejs_26 ]; };
        };
    };
}
