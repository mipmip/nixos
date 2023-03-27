{ lib, fetchFromGitHub, crystal }:

crystal.buildCrystalPackage rec {
  pname = "skull";
  version = "v0.1.2";

  src = fetchFromGitHub {
    owner = "mipmip";
    repo = "skull";
    rev = "v0.1.1";
    sha256 = "sha256-/D0i69OlyM5PcXjV/D2fi60wZAylVyWxPKdJ8xd5uPg=";
  };

  shardsFile = ./shards.nix;
  doCheck = false;

  meta = with lib; {
    description = "git repos organized by install tool";
    homepage = "https://github.com/mipmip/skull";
    license = licenses.mit;
  };
}
