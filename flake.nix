{
  description = "my epic vims collection";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
  nixosConfigurations = {
   nixos-glenn = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit system; };

    modules = [
     ./nixos/configurations.nix
     ];

   };
   };
    devShells.${system}.default =
      pkgs.mkShell
        {
          buildInputs = [
	    pkgs.neovim
	    pkgs.vim
	    ];

	    shellHook = ''
	      echo "hello glenn"
	    '';
        };


  };
}
