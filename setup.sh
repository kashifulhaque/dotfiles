#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
  echo "GNU stow is not installed."
  echo "Install it with: sudo apt install -y stow"
  exit 1
fi

cd "$DOTFILES_DIR"

# Use --adopt to handle existing files (e.g. ~/.bashrc)
# --adopt moves existing target files into the stow directory,
# then we restore our version via git checkout
echo "Stowing dotfiles from $DOTFILES_DIR ..."
stow --adopt -v .

# Restore our dotfiles versions (--adopt may have overwritten them)
echo "Restoring dotfiles to repository versions ..."
git checkout -- .

echo "Done! Dotfiles are symlinked."
