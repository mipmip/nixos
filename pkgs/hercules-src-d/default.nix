{ lib, buildGoModule, fetchgit }:
buildGoModule rec {
  pname = "hercules-src-d";
  version = "10.7.2";

  src = fetchgit {
    url = "https://github.com/src-d/hercules.git";
    rev = "v${version}";
    sha256 = "sha256:0245arvz774gc9pbd0ms3nfxg60h4bxxdrsg8vzkn294fh6cd0ra";
  };

  vendorSha256 = "sha256:1xxahwg59jnadn7as0h1lyzqlxxiq2z4zybm1mkw4l6vxc7gysqc";



  meta = with lib; {
    description = ''
       Gaining advanced insights from Git repository history.
    '';
    homepage = "https://github.com/src-d/hercules";
    license = licenses.asl20;
  };
}

