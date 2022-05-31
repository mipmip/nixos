{ lib, buildGoModule, fetchgit }:
buildGoModule rec {
  pname = "smug";
  version = "0.2.4";

  src = fetchgit {
    url = "https://github.com/src-d/hercules.git";
    rev = "v${version}";
    sha256 = "";
  };

  vendorSha256 = "sha256:xxx";

  meta = with lib; {
    description = ''
      https://github.com/src-d/hercules
    '';
    homepage = "https://github.com/ivaaaan/smug";
    license = licenses.mit;
  };
}

