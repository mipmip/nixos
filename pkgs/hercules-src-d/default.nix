{ lib, buildGoModule, fetchgit }:
buildGoModule rec {
  pname = "hercules-src-d";
  version = "10.7.2";

  src = fetchgit {
    url = "https://github.com/src-d/hercules.git";
    rev = "v${version}";
    sha256 = "sha256:0245arvz774gc9pbd0ms3nfxg60h4bxxdrsg8vzkn294fh6cd0ra";
  };

  vendorSha256 = "sha256:1rba5rpvlr8dyhj145b5i57pm4skfpj3vm7vydkn79k6ak6x985x";



  meta = with lib; {
    description = ''
       Gaining advanced insights from Git repository history.
    '';
    homepage = "https://github.com/src-d/hercules";
    license = licenses.asl20;
  };
}

