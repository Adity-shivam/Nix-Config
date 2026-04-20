{
  description = "Nixos config flake";

  inputs = {
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs_unstable.follows = "nixpkgs_unstable"; # inputs.home-manager.inputs.nixpkgs_unstable is same as inputs.nixpkgs_unstable
     };
  };

  outputs = { self, nixpkgs_unstable, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations.Nix-Chan = nixpkgs_unstable.lib.nixosSystem {
      specialArgs = {inherit inputs;}; # inherit input is same as inputs = inputs
      modules = [
        ./configuration.nix
         inputs.home-manager.nixosModules.default 
      ];
    };
  };
}
