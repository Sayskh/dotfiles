{...}: {
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
      middleEmulation = false;
    };
    touchpad = {
      accelProfile = "adaptive";
      naturalScrolling = true;
      tapping = true;
      clickMethod = "clickfinger";
      disableWhileTyping = true;
    };
  };

  services.xserver.autoRepeatDelay = 200;
  services.xserver.autoRepeatInterval = 25;
}
