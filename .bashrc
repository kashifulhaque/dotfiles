#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias up='docker compose up --build -d'
alias down='docker compose down -v'
alias ls='eza --group-directories-first --icons'
alias ll='eza -al --group-directories-first --icons'
alias yay='yay --noconfirm'
alias paru='paru --noconfirm'
alias listpkgs='yay -Qe'
alias grep='grep --color=auto'
alias fman='compgen -c | fzf | xargs tldr'
alias cat='bat -p'
alias logout='sudo pkill -u $USER'
PS1='[\u@\h \W]\$ '

# NixOS stuff
alias config='nvim /etc/nixos/configuration.nix'
alias rebuild='sudo nixos-rebuild switch'
alias gc='sudo nix-collect-garbage -d'
alias old='sudo nix-env --list-generations'

# Python stuff
alias pyenv='python -m venv .venv'
alias venv='source .venv/bin/activate'
alias pipr='python -m pip install -r requirements.txt'
alias freeze='python -m pip freeze > requirements.txt'

# Editing bashrc stuff
alias bashrc='nvim ~/.bashrc'
alias src='source ~/.bashrc'
alias migrate='stow --adopt ~/dotfiles/'

# Add ~/.local/bin to PATH
export PATH=/home/ifkash/.local/bin:$PATH

# Fancy shell prompt
eval "$(oh-my-posh init bash --config ~/.config/omp/themes/lambda.omp.json)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export EDITOR="nvim"

# Run freshfetch on start of a new terminal
freshfetch
