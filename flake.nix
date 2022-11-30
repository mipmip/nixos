{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    comma.url = "github:nix-community/comma";

  };

  outputs = inputs: {

    nixosConfigurations.ojs = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules =
        let
          defaults = { pkgs, ... }: {
            _module.args.unstable = import inputs.unstable { inherit (pkgs.stdenv.targetPlatform) system; };
          };
        in [
          defaults
          ./hosts/ojs/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
          }
      ];
    };

    nixosConfigurations.billquick = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules =
        let
          defaults = { pkgs, ... }: {
            _module.args.unstable = import inputs.unstable { inherit (pkgs.stdenv.targetPlatform) system; };
          };
        in [
          defaults
          ./hosts/billquick/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
          }
      ];

    };

  };
}
