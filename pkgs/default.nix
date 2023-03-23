{ pkgs ? import <nixpkgs> {} }:

let
  callPackage = pkgs.newScope self;
  self = rec {

    callPackage_i686  = pkgs.lib.callPackageWith (pkgs.pkgsi686Linux // self);

    #32bit
    hl4150cdn         = callPackage_i686 ./drivers/hl4150cdn                     { };

    crelease          = pkgs.callPackage ./utils/crelease                        { };
    cryptobox         = pkgs.callPackage ./utils/cryptobox                       { };

    gnome-screenshot  = pkgs.callPackage ./patched-software/gnome-screenshot     { };

    fred              = pkgs.callPackage ./pims-projects/fred                    { };
    embgit            = pkgs.callPackage ./pims-projects/embgit                  { };
    mip-crystal       = pkgs.callPackage ./pims-projects/mip-crystal             { };
    mip-rust          = pkgs.callPackage ./pims-projects/mip-rust                { };

    gnomeExt-gs-git   = pkgs.callPackage ./gnome-shell-extensions/gs-git         { };

  };
in self
