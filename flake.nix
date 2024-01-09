{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      jade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./nixos/configurations/jade
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];
          }
        ];
      };
    };
  };
}
