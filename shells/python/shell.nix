{ pkgs ? import <nixpkgs> {} }:

let

    custom-python = pkgs.mkPython {
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
  ];
}

