{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs"; # inputs.home-manager.inputs.nixpkgs_unstable is same as inputs.nixpkgs_unstable
     };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video

    # Use sudo nixos-rebuild switch --flake .#Nix-Chan to use this
    nixosConfigurations.Nix-Chan = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;}; # inherit input is same as inputs = inputs
      modules = [
        ./hosts/HP-Victus/configuration.nix
         inputs.home-manager.nixosModules.default 
      ];
    };
  };
}
