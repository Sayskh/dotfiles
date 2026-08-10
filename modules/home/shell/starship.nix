# Starship prompt
{...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Config managed via symlink from config/starship/starship.toml
}
