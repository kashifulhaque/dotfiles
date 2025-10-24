## **My dotfiles for MacOS**

### Tools used
- GNU stow
  - Add `stow` to the list of packages in [`~/.config/home-manager/home.nix`](.config/home-manager/home.nix)
  - Run `home-manager switch`

### To restore
- Clone this repo
- Run the following command:
```shell
stow .;
```
