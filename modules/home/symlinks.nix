{config, ...}: let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
in {
  xdg.configFile = {
    "kitty".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/kitty";
    "nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/nvim";
    "quickshell".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/quickshell";
    "fastfetch".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/fastfetch";
    "starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/starship/starship.toml";
    "cava".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/cava";
    "rmpc".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/rmpc";
    "mangowc".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/mangowc";
    "wal".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/wal";
  };
}

