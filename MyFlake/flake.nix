{
  description = "A very basic flake";

  inputs = {
    nixpkgs_unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs_stable.url = "github:nixos/nixpkgs?ref=release-25.11";
  };
# use Nix flake update to update these channel's commit

#outputs = { self, nixpkgs_unstable, nixpkgs_stable }: 
#outputs = inputs: but then instead of nixpkgs_stable have to use inputs.nixpkgs_stable OR USE BOTH

  outputs = {nixpkgs_unstable, ...} @inputs: # nixpkgs_unstable can be used directly others thru input.
  let 
    pkgs_unstable = nixpkgs_unstable.legacyPackages.x86_64-linux;
    pkgs_stable = inputs.nixpkgs_stable.legacyPackages.x86_64-linux;
  in
  {
    packages.x86_64-linux.hello_unstable = pkgs_unstable.hello;
    packages.x86_64-linux.hello_stable = pkgs_stable.hello;
    # can be run using nix run .#hello_stable or /etc/nixos/MyFlake#hello_stable	

    packages.x86_64-linux.default = pkgs_unstable.hello;

  };
}
