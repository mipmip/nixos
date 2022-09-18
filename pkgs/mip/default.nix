{ lib, fetchFromGitHub, crystal }:

crystal.buildCrystalPackage rec {
  pname = "mip";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "mipmip";
    repo = "mip";
    rev = "8a67307f0b0bf63b005b0e59ec02e85e2516abc9";
    sha256 = "071xj19jbsz5081v72q37zjxf4ar7ixw1iiawwl461z1ab8ysg48";
  };

  shardsFile = ./shards.nix;
  doCheck = false;

  meta = with lib; {
    description = "Fast and simple markdown viewer";
    homepage = "https://github.com/mipmip/mip";
    license = licenses.mit;
  };
}
