{ lib, fetchFromGitHub, crystal }:

crystal.buildCrystalPackage rec {
  pname = "fred";
  version = "v0.4.0";

  src = fetchFromGitHub {
    owner = "linden-project";
    repo = "fred";
    rev = "v0.4.0";
    sha256 = "sha256-14IXveCtkbNKnH3DvN//xEcozZAcNtVRWDb3jk4aKl4=";
  };

  shardsFile = ./shards.nix;
  doCheck = false;

  meta = with lib; {
    description = "Fred, a cli front matter editor";
    homepage = "https://github.com/linden-project/fred";
    license = licenses.mit;
  };
}
