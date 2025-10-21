
eval "$(/opt/homebrew/bin/brew shellenv)"

# Nix (ensure nix profile is on PATH)
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
elif [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
