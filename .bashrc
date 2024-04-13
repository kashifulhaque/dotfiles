#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases file listing
alias ls='eza --group-directories-first --icons'
alias ll='eza -al --group-directories-first --icons'

# NixOS stuff
alias nix-config='nvim /etc/nixos/configuration.nix'
alias nix-rebuild='sudo nixos-rebuild switch'
alias nix-upgrade='sudo nixos-rebuild switch --upgrade'
alias nix-gc='sudo nix-collect-garbage -d'
alias nix-old='sudo nix-env --list-generations'

# Python stuff
alias pyenv='python -m venv .venv'
alias venv='source .venv/bin/activate'
alias pipr='python -m pip install -r requirements.txt'
alias freeze='python -m pip freeze > requirements.txt'

# Python + NixOS + Micromamba
alias init-mamba='cp ~/fhs_environment.nix .'
alias init-env='nix-shell fhs_environment.nix'
alias conda='micromamba'

# Editing bashrc stuff
alias bashrc='nvim ~/.bashrc'
alias src='source ~/.bashrc'

# Docker aliases
alias up='docker compose up --build -d'
alias down='docker compose down -v'

# Git aliases
alias ga='git add .'
alias gs='git status'
alias gi='git init'

# tmux aliases
alias tmux='tmux -u'

# Other aliases
alias copy='rsync -ah --progress'
alias download='http --download'
alias grep='grep --color=auto'
alias fman='compgen -c | fzf | xargs tldr'
alias cat='bat -p'
alias logout='sudo pkill -u $USER'
alias mkdir='mkdir -p'
alias less='moar'

# Fancy shell prompt
eval "$(oh-my-posh init bash --config ~/.config/omp/themes/tokyonight_storm.omp.json)"

# Add homebrew
export PATH=/usr/local/bin:$PATH

export EDITOR="nvim"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ifkash/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ifkash/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ifkash/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ifkash/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

. "$HOME/.cargo/env"
