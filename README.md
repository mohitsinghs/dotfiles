<h1 align="center">dotfiles</h1>
<p align="center">
  <b>automated configurations</b><br/>
  <sub>for local and remote machines running ubuntu</sub>
</p>
<br />

## Install

To install everything

```sh
curl -fsSL sh.mohitsingh.in | bash
```

## Screenshots

![vscode](https://user-images.githubusercontent.com/4941333/115149391-7fc87100-a081-11eb-9efa-dc9026190fa7.png)
![vim+tmux](https://user-images.githubusercontent.com/4941333/115153605-8b716300-a094-11eb-82ff-a9090f887887.png)

## Scripts

- [`install`][1] - install everything.
- [`essential`][2] - install tools that I use frequently.
- [`shell`][3] - setup zsh with a nice looking useful prompt.
- [`vim`][4] - setup neovim with coc, fzf and other useful plugins.
- [`code`][5] - setup vscodium with extensions.
- [`docker`][6] - install docker.
- [`databases`][7] - install postgres, mysql etc.
- [`go`][8] - install latest golang.
- [`node`][9] - install node 14.x along with yarn.
- [`highload`][10] - tweak system for high load.
- [`kube`][11] - install kube\*, terraform and helm

[1]: scripts/install
[2]: scripts/essential
[3]: scripts/shell
[4]: scripts/vim
[5]: scripts/code
[6]: scripts/docker
[7]: scripts/databases
[8]: scripts/go
[9]: scripts/node
[10]: scripts/highload
[11]: scripts/kube

## Commands

- **`repo`** - switch between my local repositories.
- **`upblock`** - update host files to block crap
- **`upall`** - for usual updates
- **`dclean`** - cleanup docker images
