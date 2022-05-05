{ pkgs ? import <nixpkgs> {} }:

let

    custom-python = nixpkgs.mkPython {
        python = "python39Full";
        requirements = ''
            pip
            ipython
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
