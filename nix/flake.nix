{
  description = "MSK's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    kanata.url = "path:./flakes/kanata";
    kanata.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      kanata,
    }:
    let
      system = "aarch64-darwin";
      username = "mohammadk";
      configuration = ./configuration.nix;

      home-manager-configs.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        # user specific config
        users.${username} = import ./home.nix;

        extraSpecialArgs = {
          inherit username;
        };
      };

      work-macbook-config = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          home-manager-configs
        ];
        specialArgs = {
          inherit
            inputs
            system
            username
            kanata
            ;
        };
      };
    in
    {
      darwinConfigurations = {
        default = work-macbook-config;
      };
    };
}
