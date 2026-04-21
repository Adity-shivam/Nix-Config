{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
     inputs.nixpkgs.follows = "nixpkgs-unstable"; # inputs.home-manager.inputs.nixpkgs is same as inputs.nixpkgs_unstable and do not reinstall two version of nixpkgs/nixos-unstable
    };
  };

  outputs = { self, nixpkgs-unstable, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video

    # Use sudo nixos-rebuild switch --flake .#Nix-Chan to use this
    nixosConfigurations.Nix-Chan = nixpkgs-unstable.lib.nixosSystem {
      specialArgs = {inherit inputs;}; # inherit input is same as inputs = inputs. This let us use inputs in the modules below
      modules = [
        ./hosts/HP-Victus/configuration.nix
        inputs.home-manager.nixosModules.Nix-Chan
      ];
    };
  };
}
