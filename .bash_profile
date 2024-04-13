if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
. "$HOME/.cargo/env"
