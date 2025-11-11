### Load API keys
if [ -f "$HOME/.api_keys" ]; then
  source "$HOME/.api_keys"
fi

### Aliases for file listing
# Enhanced basic listing with git status if in a repo
alias ls='eza --header --group-directories-first --icons --git'
# Long listing with additional details
alias ll='eza -alh --header --group-directories-first --icons --git --time-style=long-iso'

# Alias for download
alias dl='http --download'

# ALias for qemu
alias qemu="qemu-system-x86_64"

# Don't generate the __pycache__ folder
export PYTHONDONTWRITEBYTECODE=1

### Aliases
alias mkdir='mkdir -p'
alias tmux='tmux -u'
alias htop='sudo mactop'

# Set nvim as default editor
export EDITOR='nvim'

# SSH into my hetzner VM
alias ssh-vm='ssh ifkash@vm.ifkash.dev'

### Mac OS Nix pkg manager
# Build and clean
alias hm-build='home-manager switch && sudo nix-collect-garbage -d'
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/kashif/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

### Oh My Posh prompt
eval "$(oh-my-posh init zsh --config ~/.config/omp/themes/robbyrussell.omp.json)"

### Mise
eval "$(mise activate zsh)"

### Config for LLVM
export PATH="$PATH:$(brew --prefix)/opt/llvm/bin"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/Users/kashif/.bun/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export TERM=xterm
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/opt/ffmpeg/lib":$DYLD_FALLBACK_LIBRARY_PATH

# Quick kernel registration for Zed/Jupyter
uvkernel() {
    local name="${1:-$(basename $PWD)}"
    uv run python -m ipykernel install --user --name "$name" --display-name "Python ($name)"
}

