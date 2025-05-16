{ lib, ... } : {

  options.nixos.tex.enable = lib.mkEnableOption "enable TeX and Markdown tools";

}
