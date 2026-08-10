{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "command-not-found"
        "colored-man-pages"
        "extract"
        "z"
      ];
    };

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

    initExtra = ''
      eval "$(fzf --zsh)"
      fastfetch
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
    enableZshIntegration = true;
    icons = "auto";
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}

