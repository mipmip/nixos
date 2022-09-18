{ lib, fetchFromGitHub, crystal }:

crystal.buildCrystalPackage rec {
  pname = "mip";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "mipmip";
    repo = "mip";
    rev = "846b1c26599ffe90afa96e9f4f64300250aa216d";
    sha256 = "071xj19jbsz5081v72q37zjxf4ar7ixw1iiawwl461z1ab8ysg48";
  };

  shardsFile = ./shards.nix;
  doCheck = false;

  meta = with lib; {
    description = "Fred, a cli front matter editor";
    homepage = "https://github.com/linden-project/fred";
    license = licenses.mit;
  };
}
