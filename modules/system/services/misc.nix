{...}: {
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.dconf.enable = true;
  programs.ssh.startAgent = true;

  services.gnome.gnome-keyring.enable = true;
}

