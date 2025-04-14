{config, pkgs, inputs, ...}:{

    environment.systemPackages = [
      inputs.mip.packages."${ pkgs.system }".default
    ];
}
