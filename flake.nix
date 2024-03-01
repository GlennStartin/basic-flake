{
  description = "My first flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos-glenn = lib.nixosSystem {
	modules = [./nixos/configuration.nix ];
	};
    };

    homeConfigurations = {
       "glenn@nixos-glenn" = home-manager.lib.homeManagerConfiguration {
         pkgs = nixpkgs.legacyPackages.${system};
	 modules = [./home-manager/home.nix];
       };
    };
  };
}
