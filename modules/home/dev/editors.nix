{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    lua-language-server
    nil
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    pyright

    stylua
    alejandra
    nodePackages.prettier
    black

    ripgrep
    fd
    tree-sitter
    gcc
  ];
}
