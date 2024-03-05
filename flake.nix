{
  description = "My first flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos-glenn = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
	modules = [./nixos/configuration.nix ];
	};
    };

    homeConfigurations = {
       "glenn@nixos-glenn" = home-manager.lib.homeManagerConfiguration {
         inherit pkgs;
	 extraSpecialArgs = { inherit inputs outputs; };
	 modules = [./home-manager/home.nix];
       };
    };
  };
}
