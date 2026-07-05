{
    description = "Troels NixOs flake";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        ragenix.url = "github:yaxitech/ragenix";
        ragenix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, ragenix, home-manager, ...}@inputs: {
    nixosConfigurations = {
        twix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ragenix.nixosModules.default
	    ./hardware/laptop.nix
            ./configuration.nix
          ];
        };
	mars = nixpkgs.lib.nixosSystem {
	  system = "x86_64-linux";
	  specialArgs = { inherit inputs; };
	  modules = [
	    ragenix.nixosModules.default
	    ./hardware/zbook-g1a.nix
            ./configuration.nix
          ];
	};
        server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ragenix.nixosModules.default
            ./server.nix
          ];
        };
      };
    };
}
