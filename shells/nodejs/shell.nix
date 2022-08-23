with (import <nixpkgs> {});

mkShell {
  buildInputs = [
    nodejs
    yarn
  ];
  shellHook = ''
  '';
}

