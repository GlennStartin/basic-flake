{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }: 
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos-glenn = lib.nixosSystem {
	modules = [./nixos/configuration.nix ];
	};
    };
  };
}
