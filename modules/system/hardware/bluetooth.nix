{...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        FastConnectable = true;
        JustWorksRepairing = "always";
        MultiProfile = "multiple";
      };
      LE = {
        MinConnectionInterval = 7;
        MaxConnectionInterval = 9;
        ConnectionLatency = 0;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;
}
