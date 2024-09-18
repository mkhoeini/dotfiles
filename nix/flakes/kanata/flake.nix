{
  description = "Kanata binary package for macos";

  outputs =
    { self, nixpkgs }:
    let

      # System types to support.
      supportedSystems = [ "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        }
      );

    in

    {

      overlay = final: prev: { kanata = final.callPackage ./. { }; };

      overlays.default = self.overlay;

      packages = forAllSystems (system: {
        inherit (nixpkgsFor.${system}) kanata;
      });

      defaultPackage = forAllSystems (system: self.packages.${system}.kanata);

      # A NixOS module, if applicable (e.g. if the package provides a system service).
      nixosModules.hello =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [ self.overlay ];

          environment.systemPackages = [ pkgs.kanata ];

          #systemd.services = { ... };
        };

    };
}
