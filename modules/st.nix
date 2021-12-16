{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (st.overrideAttrs (oldAttrs: rec {
      buildInputs = oldAttrs.buildInputs ++ [ harfbuzz ];
      patches = [
        (fetchpatch {
          url = "https://st.suckless.org/patches/ligatures/0.8.4/st-ligatures-20210824-0.8.4.diff";
          sha256 = "1mz7dlyc5zykmvk8q33v2090d3immxzrd06x1snyv28z4q0szds8";
        })

        (fetchpatch {
          url = "https://st.suckless.org/patches/cyclefonts/st-cyclefonts-0.8.4.diff";
          sha256 = "1bba57yn3ch6qnvq1w5lz45y0670hjdh7mv72qrand7yhpl2jsyw";
        })

        (fetchpatch {
          url = "https://st.suckless.org/patches/desktopentry/st-desktopentry-0.8.4.diff";
          sha256 = "0v0hymybm2yplrvdjqysvcyhl36a5llih8ya9xjim1fpl609hg8y";
        })

        (fetchpatch {
          url = "https://st.suckless.org/patches/blinking_cursor/st-blinking_cursor-20211116-2f6e597.diff";
          sha256 = "1k32nynyc8fvw2jb0sh2bll68c63xaj2lksgs9wnqlw30xn7ymw6";
        })

      ];

      configFile = writeText "config.def.h" (builtins.readFile ../resources/st/config.h);
      postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
#      postPatch = oldAttrs.postPatch ++ ''cp ${configFile} config.def.h'';
    }))
  ];
}

