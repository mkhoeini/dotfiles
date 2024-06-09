{
  description = "MSK's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = ./configuration.nix;
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#work-macbook

    darwinConfigurations = rec {
      work-macbook = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
        specialArgs = { inherit inputs; };
      };

      # Hostname configuration
      CG4NV2NWGL = work-macbook;
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."work-macbook".pkgs;
  };
}
