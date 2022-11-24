{ config, inputs, system, pkgs, ... }:

{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.0.0.126/32" ];
      #dns = [ "1.1.1.1" ];
      privateKeyFile = "/etc/secrets/wg-tracklib-key";

      peers = [
        {
          publicKey = "QGTFSDQ3KirYWvoUaLeVvWkupuDGy+0Kw5o5w3i6bBk=";
          allowedIPs = [
            "108.128.202.66/32"
            "18.34.240.0/22"
            "18.34.32.0/20"
            "3.248.191.174/32"
            "3.249.205.218/32"
            "3.251.110.208/28"
            "3.251.110.224/28"
            "3.5.64.0/21"
            "3.5.72.0/23"
            "34.240.195.73/32"
            "34.242.244.140/32"
            "34.244.143.75/32"
            "34.245.13.201/32"
            "34.246.190.131/32"
            "34.253.203.229/32"
            "34.253.65.159/32"
            "52.17.210.58/32"
            "52.210.62.128/32"
            "52.215.129.193/32"
            "52.218.0.0/17"
            "52.30.141.158/32"
            "52.49.234.215/32"
            "52.92.0.0/17"
            "54.229.51.218/32"
            "63.33.57.42/32"
            "63.33.80.225/32"
          ];

#          allowedIPs = [
#            "18.34.240.0/22"
#            "18.34.32.0/20"
#            "3.248.191.174/32"
#            "3.249.205.218/32"
#            "3.251.110.208/28"
#            "3.251.110.224/28"
#            "3.5.64.0/21"
#            "3.5.72.0/23"
#            "34.240.195.73/32"
#            "34.242.244.140/32"
#            "34.244.143.75/32"
#            "34.245.13.201/32"
#            "34.246.190.131/32"
#            "34.253.203.229/32"
#            "34.253.65.159/32"
#            "52.17.210.58/32"
#            "52.214.62.56/32"
#            "52.214.93.103/32"
#            "52.215.227.9/32"
#            "52.218.0.0/17"
#            "52.49.234.215/32"
#            "52.50.3.164/32"
#            "52.92.0.0/17"
#            "54.229.51.218/32"
#            "63.33.57.42/32"
#            "63.33.80.225/32"
#          ];

          endpoint = "108.128.244.6:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };


}