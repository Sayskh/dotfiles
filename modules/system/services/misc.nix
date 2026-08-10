{...}: {
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.dconf.enable = true;

  services.gnome.gnome-keyring.enable = true;
}


