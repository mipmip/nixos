{ ... }:

{
  imports = []
  ++
    map (n: "${./programs}/${n}") (builtins.attrNames (builtins.readDir ./programs))
  ++
    map (n: "${./roles}/${n}") (builtins.attrNames (builtins.readDir ./roles))
  ++
    map (n: "${./services}/${n}") (builtins.attrNames (builtins.readDir ./services));
}
