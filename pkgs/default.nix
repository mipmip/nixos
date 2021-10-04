{ pkgs ? import <nixpkgs> {} }:

let
  callPackage = pkgs.newScope self;
  self = rec {
    smug = pkgs.callPackage ./smug { };
  };
in self
