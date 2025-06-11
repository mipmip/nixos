{
  home.file = {
    ".config/skulls.yaml" = {
      source = ./skulls.yaml;
    };
  };

  #v = builtins.fromJSON (builtins.readFile "/path/to/example.json")
}
