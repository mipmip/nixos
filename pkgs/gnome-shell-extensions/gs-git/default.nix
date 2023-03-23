{ stdenv
, lib
, fetchFromGitHub
, glib
, gettext
, sassc
, gitUpdater
, jq
, gnome
, unzip
}:

let
  extensionUuid = "gs-git@pimsnel.com";
  extensionName = "gs-git";
  sourceDir= "src"; # relative dir with extension source code

in
  stdenv.mkDerivation rec {
    pname = "gnome-shell-extension-gs-git";
    version = "1";

    src = fetchFromGitHub {
      owner = "mipmip";
      repo = "gs-git";
      rev = "223bb2e6878fb6cb32fa5ac4b45e4635c5eba7b3";
      sha256 = "sha256-Bz6+4Obv4GuvrHSeoyzCBLre+NvyvfniY1j5P70bfag=";

#      postFetch = ''
#        cat ${sourceDir}/metadata.json | jq '.uuid = "${extensionUuid}"' > ${sourceDir}/metadata.json
#        #echo "${metadata}" | base64 --decode > $out/metadata.json
#      '';
    };

    nativeBuildInputs = [
      glib
      gettext
      sassc
      gnome.gnome-shell
      jq
      unzip
    ];

    #dontBuild = true;
    buildPhase = ''
      #cat ${sourceDir}/metadata.json | jq '.uuid = "${extensionUuid}"' > ${sourceDir}/metadata.json
      bash ./install.sh zip
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/gnome-shell/extensions/
      unzip git@eexpss.gmail.com.shell-extension.zip -d $out/share/gnome-shell/extensions/${extensionUuid}
      #cp -r -T src $out/share/gnome-shell/extensions/${extensionUuid}
      runHook postInstall
    '';

    makeFlags = [
      "INSTALLBASE=${placeholder "out"}/share/gnome-shell/extensions"
      ];

      passthru = {
        extensionUuid = "${extensionUuid}";
        extensionPortalSlug = "${extensionName}";

#    updateScript = gitUpdater {
#      rev-prefix = "extensions.gnome.org-v";
#    };
    };

    meta = with lib; {
      description = "Gnome Extension to monitor git directory for changes. (enhanced fork by mipmip)";
      longDescription = description;
      homepage = "https://github.com/mipmip/gs-git";
      license = licenses.gpl2Plus;
      maintainers = with maintainers; [ mipmip ];
    };
  }
