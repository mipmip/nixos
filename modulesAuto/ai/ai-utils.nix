{ config, lib, pkgs, unstable, ... }:

{
  config = lib.mkIf config.nixos.ai.enable {
    environment.systemPackages = with pkgs; [
      unstable.aider-chat-full
      mods
    ];
  };
}
