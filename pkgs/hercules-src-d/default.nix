{ lib, buildGoModule, fetchgit }:
buildGoModule rec {
  pname = "hercules-src-d";
  version = "10.7.2";

  src = fetchgit {
    url = "https://github.com/src-d/hercules.git";
    rev = "v${version}";
    sha256 = "";
  };

  vendorSha256 = "";

  meta = with lib; {
    description = ''
       Gaining advanced insights from Git repository history.
    '';
    homepage = "https://github.com/src-d/hercules";
    license = licenses.asl20;
  };
}

