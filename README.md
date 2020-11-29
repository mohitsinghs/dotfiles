<h1 align="center">dotfiles</h1><br><br>
<p align="center">
  <b>dotfiles for local machines and remote boxes running ubuntu</b><br/>
</p>

<br />

# Install

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
- [`databases`][6] - install mongo, postgres, mysql etc.
- [`go`][7] - install latest golang.
- [`node`][8] - intall node 14.x along with yarn.
- [`user`][9] - create a new user ( for remote boxes ).
- [`highload`][10] - tweak system for high load ( for remote boxes ).

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

## Commands

- **`repo`** - switch between my local repositories.
- **`ytd`** - scrap videos from youtube
- **`ytdm`** - scrap music from youtube
- **`upytd`** - update local ytd ( my patched youtube-dl )
- **`upblock`** - update host files to block crap
- **`upall`** - for usual updates

## Contributing

Feel free to help improving this repo by

- creating issues for things that are broken
- creating pull requests of things that I've missed
