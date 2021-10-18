{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    silver-searcher
    fzf
    bat
    apg
    glow
    mipmip_pkg.smug
    ctags
    git-lfs
    jq
    imagemagick
    python3
    openssl
  ]
  ++ (if pkgs.stdenv.isDarwin then
  [
    unixtools.watch
  ]
  else
  [
    vifm
    wtf
    binutils
    gettext
    gcc
    ruby
    rake
    bind.dnsutils
    psmisc
    util-linux
    file
    pkg-config
    whois
  ]
  );
}
