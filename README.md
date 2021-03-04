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
- [`kube`][11] - install kubectl, minikube, terraform and helm
- [`databases`][6] - install postgres, mysql etc.
- [`go`][7] - install latest golang.
- [`node`][8] - install node 14.x along with yarn.
- [`user`][9] - create a new user.
- [`highload`][10] - tweak system for high load.

[1]: scripts/install
[2]: scripts/essential
[3]: scripts/shell
[4]: scripts/vim
[5]: scripts/docker
[6]: scripts/databases
[7]: scripts/go
[8]: scripts/node
[9]: scripts/user
[10]: scripts/highload
[11]: scripts/kube

## Commands

- **`repo`** - switch between my local repositories.
- **`ytd`** - scrap videos from youtube
- **`ytdm`** - scrap music from youtube
- **`upytd`** - update local [ytd](https://github.com/mohitsinghs/ytd)
- **`upblock`** - update host files to block crap
- **`upall`** - for usual updates

## Contributing

Feel free to help improving this repo by

- creating issues for things that are broken
- creating pull requests of things that I've missed
