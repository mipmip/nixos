environment.systemPackages =
let
  comma = (import (pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "comma";
    rev = "v1.2.0";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  })).default;
in [ comma ];
