{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    unzip
    zip
    file
    killall
    htop
    btop
    tree

    wl-clipboard
    wl-screenrec
    grim
    slurp
    swww
    wlr-randr

    xfce.thunar
    xfce.thunar-volman

    polkit_gnome
    networkmanagerapplet
    libnotify
    brightnessctl
    playerctl
    pamixer
    pavucontrol

    (python3.withPackages (ps:
      with ps; [
        dbus-python
        pygobject3
        pillow
      ]))
  ];
}

