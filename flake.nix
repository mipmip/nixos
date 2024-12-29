{

  inputs = {

    ## MAIN NIXPKGS
    nixpkgs-2211.url = "github:NixOS/nixpkgs/nixos-22.11"; # GNOME 43.2
    #nixpkgs-2305.url = "github:NixOS/nixpkgs/nixos-23.05";# GNOME 44.2?
    nixpkgs-2311.url = "github:NixOS/nixpkgs/nixos-23.11"; # GNOME 45.2
    nixpkgs-2405.url = "github:NixOS/nixpkgs/nixos-24.05"; # GNOME 46
    nixpkgs-inkscape13.url = "github:leiserfg/nixpkgs?ref=staging";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11"; # GNOMe 47

    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-hardware-t2.url = "github:nixos/nixos-hardware/863e3ca9988f34c370bd660a5efc3e20eb7ad38b";


    ## HOME MANAGER
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ## OTHER
    agenix.url = "github:ryantm/agenix";

    nixified-ai = { url = "github:nixified-ai/flake"; };

    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    bmc.url = "github:wearetechnative/bmc";
    race.url = "github:wearetechnative/race";

    jsonify-aws-dotfiles.url = "github:mipmip/jsonify-aws-dotfiles";
    myhotkeys.url = "github:mipmip/gnome-hotkeys.cr/0.2.7";
    shellstuff.url = "github:mipmip/nix-shellstuff";
    dirtygit.url = "github:mipmip/dirtygit";
    ghostty.url = "github:ghostty-org/ghostty";
    skull.url = "github:mipmip/skull";

    nixpkgs-pine64.url = "nixpkgs/dfd82985c273aac6eced03625f454b334daae2e8";
    mobile-nixos = {
      url = "github:nixos/mobile-nixos/efbe2c3c5409c868309ae0770852638e623690b5";
      flake = false;
    };
    home-manager-pine64.url = "github:nix-community/home-manager/release-22.05";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  outputs = inputs@{

    self,

    nixpkgs,
    nixpkgs-2211,
    nixpkgs-2311,
    nixpkgs-2405,
    nixpkgs-inkscape13,
    unstable,

    home-manager,
    agenix,

    alacritty-theme,

    nixos-hardware,
    nixos-hardware-t2,

    nixified-ai,

    jsonify-aws-dotfiles, dirtygit, bmc, race, shellstuff, skull, myhotkeys,
    ghostty,

    nixpkgs-pine64, mobile-nixos, home-manager-pine64,

    nix-on-droid
    } :

    let

      importFromChannelForSystem = system: channel: import channel {
        overlays = [
          (import ./overlays)
          alacritty-theme.overlays.default
        ];
        inherit system;
        config.allowUnfree = true;
      };

      makeHomeConf = {
        username ? "pim",
        hostname,
        homedir ? "/home/pim",
        system ? "x86_64-linux",
        secondbrain ? false,
        awscontrol ? false,
        desktop ? false,
        ...
        }:
        home-manager.lib.homeManagerConfiguration {
          modules = [
            (import ./home/pim)
            {
              home.stateVersion = "24.11";
              home.username = username;
              home.homeDirectory = homedir;
              roles.secondbrain.enable = secondbrain;
              roles.awscontrol.enable = awscontrol;
              roles.desktop.enable = desktop;
            }
          ];
          pkgs = importFromChannelForSystem system nixpkgs;
          extraSpecialArgs = {
            system = system;
            inputs = inputs;
            unstable = importFromChannelForSystem system unstable;
          };
        };

      makeNixosConf = {
        hostname,
        system ? "x86_64-linux",
        extraModules ? [],
        ...
        }:

        nixpkgs.lib.nixosSystem {
          modules =
            let
              defaults = { pkgs, ... }: {
                nixpkgs.overlays = [(import ./overlays)];
                _module.args.unstable = importFromChannelForSystem system unstable;
                _module.args.pkgs-2211 = importFromChannelForSystem system nixpkgs-2211;
                _module.args.pkgs-2311 = importFromChannelForSystem system nixpkgs-2311;
              };

              extraPkgs = {
                environment.systemPackages = [
                  agenix.packages."${system}".default
                  myhotkeys.packages."${system}".myhotkeys
                  skull.packages."${system}".skull
                ];
              };

            in [
                defaults
                #nixos-hardware.nixosModules.framework-12th-gen-intel
                (./hosts + "/${hostname}/configuration.nix")

                agenix.nixosModules.default
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                }

                extraPkgs

              ] ++
            extraModules;
        };

    in
      rec {

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-classic;

      homeConfigurations."pim@hurry" = makeHomeConf {
        hostname = "hurry";
        system = "aarch64-linux";
      };

      homeConfigurations."pim@tn-nixhost" = makeHomeConf {
        hostname = "tn-nixhost";
        awscontrol = true;
      };

      homeConfigurations."pim@rodin" = makeHomeConf {
        hostname = "rodin";
        secondbrain = true;
        awscontrol = true;
        desktop = true;
      };

      homeConfigurations."pim@lego1" = makeHomeConf {
        hostname = "lego1";
        secondbrain = true;
        awscontrol = true;
        desktop = true;
      };

      homeConfigurations."pim@ojs" = makeHomeConf {
        hostname = "ojs";
        desktop = true;
      };

      homeConfigurations."pim@passieflora" = makeHomeConf {
        hostname = "passieflora";
        desktop = true;
      };

      nixosConfigurations.rodin = makeNixosConf {
        hostname = "rodin";
        extraModules = [

          #          {
          #              imports = [
          #                nixified-ai.nixosModules.invokeai
          #              ];
          #
          #              environment.systemPackages = [
          #                nixified-ai.packages.${system}.invokeai-nvidia
          #              ];
          #
          #  #            services.invokeai = {
          #  #              enable = false;
          #  #              host = "0.0.0.0";
          #  #              nsfwChecker = false;
          #  #              package = nixified-ai.packages.${system}.invokeai-nvidia;
          #  #            };
          #
          #            }


        ];
      };

      nixosConfigurations.passieflora = makeNixosConf {
        hostname = "passieflora";
        extraModules = [
          ./hosts/passieflora/nix/substituter.nix
          nixos-hardware-t2.nixosModules.apple-t2
        ];
      };

      nixosConfigurations.lego1 = makeNixosConf rec {
        hostname = "lego1";
        system = "x86_64-linux";
        extraModules = [
          nixos-hardware.nixosModules.framework-12th-gen-intel
          {
            environment.systemPackages = [
              myhotkeys.packages."${system}".myhotkeys
              ghostty.packages."${system}".ghostty
            ];
          }
        ];
      };

      nixosConfigurations.hurry = makeNixosConf {
        hostname = "hurry";
        system = "aarch64-linux";
      };

      nixosConfigurations.ojs = makeNixosConf {
        hostname = "ojs";
      };

      nixosConfigurations.gnome-45 = makeNixosConf {
        hostname = "gnome-45";
        extraModules = [
          {
            nixpkgs.config.pkgs = import nixpkgs-2311 { system = "x86_64-linux"; };
          }
        ];
      };

      nixosConfigurations.grannyos = makeNixosConf {
        hostname = "grannyos";
        extraModules = [
          {
            nixpkgs.config.pkgs = import nixpkgs-2311 { system = "x86_64-linux"; };
          }
        ];
      };

      nixosConfigurations.billquick = makeNixosConf {
        hostname = "billquick";
      };

      nixosConfigurations.pinephone = (nixpkgs-pine64.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { home-manager = home-manager-pine64; };
        modules = [
          (import "${mobile-nixos}/lib/configuration.nix" {
            device = "pine64-pinephone";
          })
          ./hosts/pesto/default.nix
        ];
      });
      pinephone-img = nixosConfigurations.pinephone.config.mobile.outputs.u-boot.disk-image;

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ ./hosts/nix-on-droid/configuration.nix ];
      };
    };
}
