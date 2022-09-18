{
  lib,
  fetchFromGitHub,
  crystal,
  pkg-config,
  cmake,
  fswatch,
  openssl,
  shards,
  nodejs,
  yarn,
  webkitgtk,
  cmark-gfm
}:


crystal.buildCrystalPackage rec {

  markdfsrc = fetchFromGitHub {
    owner = "github";
    repo = "cmark-gfm";
    rev = "9d57d8a23142b316282bdfc954cb0ecda40a8655";
    sha256 = "ekHY5EGSrJrQwlXNjKpyj7k0Bzq1dYPacRsfNZ8K+lk=";
  };

  pname = "mip";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "mipmip";
    repo = "mip";
    rev = "0ec44d08ee4dacba063564f6a89bf1b7fcc635b1";
    sha256 = "sY9gypkDwT4+KGhCvu832G3h4YdGGRpd8eB37Zp1BUo=";
  };

  shardsFile = ./shards.nix;
  doCheck = false;

  buildPhase = ''
       mkdir lib2
       for d in lib/*; do cp -Lr $d lib2/ ; done
       mv lib lib3
       mv lib2 lib
       chmod -R +w lib

       cd lib/webview
       make
       cd ../..

       cd lib/common_marker/ext
       cp -a ${markdfsrc} ./cmark-gfm
       chmod -R +w ./cmark-gfm
       ls -al
       ls -al ./cmark-gfm
       sed -i 's/git/echo/g' Makefile
       make
       cd ../../..

       #ls -al src
       crystal build --release src/mip.cr
       ls -al
  '';

  installPhase = ''
    mkdir -p $out/{bin,share}
    cp ./mip $out/bin/
    #cp -av ./asset $out/asset
  '';

  nativeBuildInputs = [
    cmark-gfm
    pkg-config
    cmake
    fswatch
    openssl
    crystal
    shards
    nodejs
    #yarn
    webkitgtk
    cmake
  ];
  buildInputs = [
    fswatch
    openssl
    crystal
    nodejs
    yarn
   webkitgtk
    cmake
  ];


  meta = with lib; {
    description = "Fast and simple markdown viewer";
    homepage = "https://github.com/mipmip/mip";
    license = licenses.mit;
  };
}
