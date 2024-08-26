{ lib, buildGoModule, fetchgit }:
buildGoModule rec {
  pname = "jsonify-aws-dotfiles";
  version = "0878f364971dd3cf59104817de4cd4dc74443bde";

  src = fetchgit {
    url = "https://github.com/mipmip/jsonify-aws-dotfiles.git";
    rev = "${version}";
    hash = "sha256-qUzb+VTjWCgwjuATBULQOIjHylUAJs3FxOQwq1i3p5s=";
  };

  vendorHash = "sha256-W6XVd68MS0ungMgam8jefYMVhyiN6/DB+bliFzs2rdk=";

  meta = with lib; {
    description = ''
      Convert aws config and credential files into a single JSON object
    '';
    homepage = "https://github.com/mipmip/jsonify-aws-dotfiles";
    license = licenses.mit;
  };
}
