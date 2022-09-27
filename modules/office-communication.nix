{ config, lib, rpath, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.slack.overrideAttrs (oldAttrs: rec {

      installPhase = ''
        runHook preInstall

        # The deb file contains a setuid binary, so 'dpkg -x' doesn't work here
        dpkg --fsys-tarfile $src | tar --extract
        rm -rf usr/share/lintian

        mkdir -p $out
        mv usr/* $out

        # Otherwise it looks "suspicious"
        chmod -R g-w $out

        for file in $(find $out -type f \( -perm /0111 -o -name \*.so\* \) ); do
          patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$file" || true
          patchelf --set-rpath ${rpath}:$out/lib/slack $file || true
        done

        # Replace the broken bin/slack symlink with a startup wrapper
        rm $out/bin/slack
        makeWrapper $out/lib/slack/slack $out/bin/slack \
          --prefix XDG_DATA_DIRS : $GSETTINGS_SCHEMAS_PATH \
          --prefix PATH : ${lib.makeBinPath [xdg-utils]} \
          --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer  --ozone-platform=wayland}}"

        # Fix the desktop link
        substituteInPlace $out/share/applications/slack.desktop \
          --replace /usr/bin/ $out/bin/ \
          --replace /usr/share/ $out/share/

        runHook postInstall
      '';

    }))


    zoom-us
    teams
  ];
}
