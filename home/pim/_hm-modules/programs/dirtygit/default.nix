{ inputs, system, ... }:

{
  home.packages = [
    inputs.shellstuff.packages."${system}".dirtygit
  ];

  home.file = {
    "./.dirtygit.yml" = {
      source = ./dirtygit.yml;
    };
  };

}
