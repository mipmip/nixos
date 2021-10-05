{ pkgs ? import <nixpkgs> {} }:

let
  callPackage = pkgs.newScope self;
  self = rec {
    callPackage_i686 = pkgs.lib.callPackageWith (pkgs.pkgsi686Linux // self);
    smug = pkgs.callPackage ./smug { };
    #hl4150cdn = pkgs.callPackage ./hl4150cdn { };
    hl4150cdn = callPackage_i686 ./hl4150cdn { };
  };
in self
