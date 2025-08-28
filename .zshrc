### Aliases for file listing
# Enhanced basic listing with git status if in a repo
alias ls='eza --header --group-directories-first --icons --git'
# Long listing with additional details
alias ll='eza -alh --header --group-directories-first --icons --git --time-style=long-iso'

# Alias for download
alias dl='http --download'

# Don't generate the __pycache__ folder
export PYTHONDONTWRITEBYTECODE=1

### Aliases
alias mkdir='mkdir -p'
alias tmux='tmux -u'

# Set nvim as default editor
export EDITOR='nvim'

# SSH into my hetzner VM
alias ssh-vm='ssh ifkash@vm.ifkash.dev'

# Starship
eval "$(starship init zsh)"

### Mac OS Nix pkg manager
# Build and clean
alias hm-build='home-manager switch && sudo nix-collect-garbage -d'
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/kashif/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

export PATH="$HOME/.local/bin:$PATH"
