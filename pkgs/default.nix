{ pkgs ? import <nixpkgs> {} }:

let
  callPackage = pkgs.newScope self;
  self = rec {

    callPackage_i686 = pkgs.lib.callPackageWith (pkgs.pkgsi686Linux // self);

    hl4150cdn = callPackage_i686 ./hl4150cdn { };

    smug      = pkgs.callPackage ./smug { };
    crelease  = pkgs.callPackage ./crelease { };
    fred      = pkgs.callPackage ./fred { };

  };
in self
