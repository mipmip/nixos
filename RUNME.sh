#!/usr/bin/env sh
#(C)2019-2022 Pim Snel - https://github.com/mipmip/RUNME.sh
CMDS=();DESC=();NARGS=$#;ARG1=$1;make_command(){ CMDS+=($1);DESC+=("$2");};usage(){ printf "\nUsage: %s [command]\n\nCommands:\n" $0;line="              ";for((i=0;i<=$(( ${#CMDS[*]} -1));i++));do printf "  %s %s ${DESC[$i]}\n" ${CMDS[$i]} "${line:${#CMDS[$i]}}";done;echo;};runme(){ if test $NARGS -eq 1;then eval "$ARG1"||usage;else usage;fi;}


make_command "sysclean" "Run nix garbage collector"
sysclean(){
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
}

make_command "sysrebuild" "NixOS Rebuild"
sysrebuild(){
  sudo nixos-rebuild switch
}

make_command "homerebuild" "Home Manager Rebuild"
homerebuild(){
  home-manager switch
}

make_command "macbrew" "Run brew bundle"
macbrew(){
  cd ~ && brew bundle
}

make_command "pcirescan" "Rescan for devices that don't wake up"
pcirescan(){
  sudo echo "1" /sys/bus/pci/rescan
}

make_command "fixmacnixpath" "set nix path on the mac"
fixmacnixpath(){
  source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
}
runme
