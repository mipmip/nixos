{ inputs, system, ... }:

{
  home.packages = [
    inputs.dirtygit.packages."${system}".dirtygit
  ];

  home.file = {
    "./.dirtygit.yml" = {
      source = ./dirtygit.yml;
    };
  };

}
