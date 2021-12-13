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
    sc-im
    jq
    yj
    imagemagick
    python3
    openssl
    direnv
    zip
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
    xorg.xkill
  ]
  );
}
