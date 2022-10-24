{
  inputs = {
    # normal nix stuff
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    # unstable url
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager stuff
    home-manager.url = "github:nix-community/home-manager/release-22.05";

    # use the version of nixpkgs we specified above rather than the one HM would ordinarily use
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    comma.url = "github:nix-community/comma";

  };

  outputs = inputs: {

    nixosConfigurations.ojs = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/ojs/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
        }
      ];
    };

    nixosConfigurations.ojs = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/billquick/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
        }
      ];
    };



  };
}
