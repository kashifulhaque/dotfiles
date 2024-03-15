# My dotfiles

Well, these are my dotfiles (a few of them, atleast!). Reference video here: [Dreams of Autonomy](https://youtu.be/y6XCebnB9gs)

## Tools needed
`git` `stow`

## Install
1. Clone the repo
```sh
git clone git@github.com:kashifulhaque/dotfiles.git ~/dotfiles
```
2. Go inside the `dotfiles` directory
```sh
cd ~/dotfiles
```
3. Use stow to bring up the changes
```sh
stow --adopt .
```

## Screenshots
<img src="./screen-1.png" />
<img src="./screen-2.png" />

## Wallpapers
[Wallpapers here](./Pictures/Wallpapers)


### Python environment using micromamba
> Read more about it [here](https://nixos.wiki/wiki/Python#micromamba)

1. Run the following commands to enable an FHS-like shell using nix in order to use micromamba
```bash
init-mamba
init-env
```
2. Now, we can use micromamba like any other linux distro
```bash
micromamba create -n py310 python=3.10 -c conda-forge -y
```
