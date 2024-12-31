{config, pkgs, ...}:{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
    ];

    customComponents = with pkgs.home-assistant-custom-components; [
      prometheus_sensor
      #"system_health"
      localtuya
      #"pushover"
      #"telegram"
      #"timer"
      #"tado"
      #"systemmonitor"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };
  };
}
