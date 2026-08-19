{config, ...}: let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/${path}";
in {
  xdg.configFile = {
    "kitty".source = link "kitty";
    "nvim".source = link "nvim";
    "quickshell".source = link "quickshell";
    "fastfetch".source = link "fastfetch";
    "starship.toml".source = link "starship/starship.toml";
    "mangowc".source = link "mangowc";
    "scripts".source = link "scripts";
  };
}
