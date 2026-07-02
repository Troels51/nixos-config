{
    description = "Troels NixOs flake";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        ragenix.url = "github:yaxitech/ragenix";
        ragenix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, ragenix, ...}@inputs: {
    nixosConfigurations = {
        twix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ragenix.nixosModules.default
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
