{ config, pkgs, ... }:

{
  home.username = "kashif";
  home.homeDirectory = "/Users/kashif";
  home.stateVersion = "25.05"; ### Do NOT change

  home.packages = with pkgs; [
    # Dev tools
    uv
    git
    ruff
    kitty
    lld_21
    neovim

    # System details
    mactop
    neofetch

    # Utils
    jq
    bat
    eza
    fzf
    sox
    vhs
    atac
    axel
    glow
    mise
    stow
    tmux
    typst
    ripgrep
    imagemagick

    # Other stuff
    qemu
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
