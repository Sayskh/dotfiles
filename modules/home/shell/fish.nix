{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fastfetch
    '';

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#nixbtw";
      update = "nix flake update ~/dotfiles";
      cleanup = "sudo nix-collect-garbage -d && nix-collect-garbage -d";

      ".." = "cd ..";
      "..." = "cd ../..";
      ll = "eza -la --icons --group-directories-first";
      ls = "eza --icons --group-directories-first";
      lt = "eza --tree --icons --level=2";
      cat = "bat";

      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph";
      gd = "git diff";

      dots = "cd ~/dotfiles";
      v = "nvim";
      f = "yazi";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultOptions = [
      "--height 40%"
      "--layout reverse"
      "--border rounded"
      "--preview-window border-rounded"
    ];
  };

  programs.bat = {
    enable = true;
    config.theme = "base16";
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
