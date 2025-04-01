{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    age
  ];

  age.secrets = let
    keyconf = keyname: {
      file = ../secrets/${keyname}.age;
      path = "/tmp/${keyname}";
      owner = "pim";
      group = "users";
      mode = "600";
    };
  in
    {

      open-api-key = keyconf "openai-api-key";
      openai-api-key-plain = keyconf "openai-api-key-plain";
      kagi-api-key-plain = keyconf "kagi-api-key-plain";
      tavily-api-key-plain = keyconf "tavily-api-key-plain";

      #    openai-api-key-old = {
      #      file = ../secrets/openai-api-key.age;
      #      path = "/tmp/openaiapikey";
      #      owner = "pim";
      #      group = "users";
      #      mode = "600";
      #    };
      #
      #    openai-api-key-plain-old = {
      #      file = ../secrets/openai-api-key-plain.age;
      #      path = "/tmp/openaiapikey-plain";
      #      owner = "pim";
      #      group = "users";
      #      mode = "600";
      #    };
  };
}
