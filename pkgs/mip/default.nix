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

  cupsdeb = fetchurl {
    url = "https://download.brother.com/welcome/dlf005942/${model}cupswrapper-1.1.1-5.i386.deb";
    sha256 = "sha256:0p76g9v79j6dpk8m41rxms6c52166zs6q5v0qlr0av79dijv8c9w";
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
      ls ${cupsdeb}
       mkdir lib2
       for d in lib/*; do cp -Lr $d lib2/ ; done
       mv lib lib3
       mv lib2 lib
       chmod -R +w lib
       cd lib/webview && make
       cd ../..
       #cd lib/common_marker/ext && make
       #cd ../../..
       #ls -al src
       crystal build --release src/mip.cr
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
