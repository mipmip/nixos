{ inputs, system, ... }:

{
  home.packages = [
    inputs.shellstuff.packages."${system}".shellstuff
  ];
}
