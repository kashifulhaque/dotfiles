{ config, pkgs, ... }:

{
  home.username = "kashif";
  home.homeDirectory = "/Users/kashif";
  home.stateVersion = "25.05"; ### Do NOT change

  home.packages = with pkgs; [
    # Dev tools
    neovim
    uv
    bun
    go
    rustup
    git
    ruff

    # System details
    neofetch
    htop

    # Utils
    stow
    tmux
    eza
    bat
    fzf
    glow
    ripgrep
    typst
    ffmpeg

    # Other stuff
    httpie
    oh-my-posh
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "kashifulhaque";
      userEmail = "haque.kashiful7@gmail.com";
    };
  };
}
