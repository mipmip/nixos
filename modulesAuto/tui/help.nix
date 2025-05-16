{ pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    cheat
    entr
  ];
}
