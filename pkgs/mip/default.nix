{ lib, fetchFromGitHub, crystal }:

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

  buildInputs = [ openssl ];

  meta = with lib; {
    description = "Fast and simple markdown viewer";
    homepage = "https://github.com/mipmip/mip";
    license = licenses.mit;
  };
}
