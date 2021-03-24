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

## Scripts

- [`install`][1] - install everything.
- [`essential`][2] - install tools that I use frequently.
- [`shell`][3] - setup zsh with a nice looking useful prompt.
- [`vim`][4] - setup neovim with coc, fzf and other useful plugins.
- [`docker`][5] - install docker and docker-compose.
- [`databases`][6] - install postgres, mysql etc.
- [`go`][7] - install latest golang.
- [`node`][8] - install node 14.x along with yarn.
- [`highload`][9] - tweak system for high load.
- [`kube`][10] - install kubectl, minikube, terraform and helm

[1]: scripts/install
[2]: scripts/essential
[3]: scripts/shell
[4]: scripts/vim
[5]: scripts/docker
[6]: scripts/databases
[7]: scripts/go
[8]: scripts/node
[9]: scripts/highload
[10]: scripts/kube

## Commands

- **`repo`** - switch between my local repositories.
- **`upblock`** - update host files to block crap
- **`upall`** - for usual updates
- **`dclean`** - cleanup docker images
