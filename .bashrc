# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# A file for all the API keys
if [ -f ~/.api_keys ]; then
  . ~/.api_keys
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ally/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ally/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ally/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ally/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

### Aliases
alias logout='sudo pkill -u $USER'
alias mkdir='mkdir -p'
alias tmux='tmux -u'
alias bat='batcat'

# SSH into my hetzner VM
alias ssh-vm='ssh ifkash@vm.ifkash.dev'

# Enhanced basic listing with git status if in a repo
alias ls='eza --header --group-directories-first --icons --git'

# Long listing with additional details
alias ll='eza -alh --header --group-directories-first --icons --git --time-style=long-iso'

# Tree view (great for visualizing directory structure)
alias lt='eza --tree --level=2 --icons'

# Sort by most recently modified
alias lr='eza -lrs modified'

# Sort by file size (largest first)
alias lS='eza -lrs size'

# List only directories
alias ld='eza -D --icons'

# Show extended attributes
alias lx='eza -lha@ --header --icons'

# Grid view (compact listing in columns)
alias lg='eza -G --icons'

# Show only git status changes
alias lc='eza --git -l --icons --no-user --no-time --no-filesize --git-ignore'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"

# go
export PATH=$PATH:/usr/local/go/bin

# To support terminal shortcuts during SSH
export TERM=xterm-256color

# Oh my posh theme
eval "$(oh-my-posh init bash --config ~/.config/omp/themes/honukai.omp.json)"

# Don't generate the __pycache__ folder
export PYTHONDONTWRITEBYTECODE=1