{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      unstable,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      system = "x86_64-linux";
    in
    {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              system
              inputs
              outputs
              unstable
              ;
          };

          modules = [
            self.nixosModules.hyprland
            self.nixosModules.docker
            self.nixosModules.keeweb
            self.nixosModules.gaming
            self.nixosModules.httpd
            self.nixosModules.polkit
            self.nixosModules.print
            self.nixosModules.vips
            ./nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        ayax0 = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."${system}";
          extraSpecialArgs = { inherit system inputs outputs; };

          modules = [
            ./home-manager/home.nix
          ];
        };
      };
    };
}
