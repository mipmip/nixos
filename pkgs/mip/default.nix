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
  webkitgtk
}:

crystal.buildCrystalPackage rec {
  pname = "mip";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "mipmip";
    repo = "mip";
    rev = "8a67307f0b0bf63b005b0e59ec02e85e2516abc9";
    sha256 = "kk4Ykah5qjyXsUU71pv291KIgdec0zkyU/s1ygKyHok=";
  };

  shardsFile = ./shards.nix;
  doCheck = false;

  nativeBuildInputs = [
    pkg-config
    cmake
    fswatch
    openssl
    crystal
    shards,
    nodejs
    yarn
    webkitgtk
    cmake
  ];
#  buildInputs = [
#    fswatch
#    openssl
#    crystal
#    nodejs
#    yarn
#    webkitgtk
#    cmake
#  ];


  meta = with lib; {
    description = "Fast and simple markdown viewer";
    homepage = "https://github.com/mipmip/mip";
    license = licenses.mit;
  };
}
