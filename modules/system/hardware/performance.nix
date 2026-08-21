{pkgs, ...}: {
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "kernel.sched_autogroup_enabled" = 0;
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 1024;
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "kernel.printk" = "3 3 3 3";
  };

  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="block", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{bInterfaceClass}=="03", ATTR{power/control}="on"
  '';

  hardware.steam-hardware.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}
