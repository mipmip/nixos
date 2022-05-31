{ lib, buildGoModule, fetchgit }:
buildGoModule rec {
  pname = "hercules-src-d";
  version = "10.7.2";

  src = fetchgit {
    url = "https://github.com/src-d/hercules.git";
    rev = "v${version}";
    sha256 = "";
  };

  vendorSha256 = "sha256:xxx";

  meta = with lib; {
    description = ''
    '';
    homepage = "https://github.com/src-d/hercules";
    license = licenses.apache;
  };
}

