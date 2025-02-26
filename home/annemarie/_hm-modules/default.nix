{ ... }:

{
  imports = []
    ++
    map (n: "${./fonts}/${n}") (builtins.attrNames (builtins.readDir ./fonts))
    ++
    map (n: "${./gnome}/${n}") (builtins.attrNames (builtins.readDir ./gnome))
    ++
    map (n: "${./programs}/${n}") (builtins.attrNames (builtins.readDir ./programs))
    ++
    map (n: "${./roles}/${n}") (builtins.attrNames (builtins.readDir ./roles));
}
