{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.ollama
    unstable.llama-cpp
  ];
  services.open-webui.enable = true;
}
