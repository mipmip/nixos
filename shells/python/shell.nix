{ pkgs ? import <nixpkgs> {} }:

let

    mach-nix = import (
        builtins.fetchGit {
            url = "https://github.com/DavHau/mach-nix/";
            ref = "refs/tags/3.3.0";
        }
    ) {};

    custom-python = mach-nix.mkPython {
        python = "python38Full";
        requirements = ''
            pip
            ipython
            griddly
            matplotlib
            pygame
        '';
        providers = {
            _default = "wheel,sdist,nixpkgs";
        };
    };
in

with pkgs;

mkShell {
  buildInputs = [
    custom-python
    # tried with and without this next line:
    gccStdenv
    # griddly requires the Vulkan-SDK. Is this it?
    vulkan-headers
    vulkan-loader
    vulkan-tools
  ];

  # tried with and without this next line:
  LD_LIBRARY_PATH="${lib.makeLibraryPath [stdenv.cc.cc]}";
}
