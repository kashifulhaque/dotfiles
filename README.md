## **My dotfiles**

### Tools used
- GNU stow:
```sh
sudo apt install -y stow
```

### To restore
- Clone this repo into your home directory:
```sh
cd ~
git clone https://github.com/kashifulhaque/dotfiles.git
cd dotfiles
```

- Run the setup script (handles existing files like `.bashrc` gracefully):
```sh
./setup.sh
```

This uses `stow --adopt` to safely handle any existing dotfiles, then restores the repo versions via `git checkout`.
