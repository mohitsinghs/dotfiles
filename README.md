# dotfiles

> My macOS configuration

## Usage

To install everything

```sh
curl -fsSL sh.mohitsingh.in | bash
```

> You can also setup things one by one

To setup brew with packages I use

```sh
curl -fsSL sh.mohitsingh.in/brew | bash
```

To configure zsh with git and tmux

```sh
curl -fsSL sh.mohitsingh.in/shell | bash
```

To install neovim with coc.nvim and other extensions

> Please make sure you have node installed before running this independently

```sh
curl -fsSL sh.mohitsingh.in/vim | bash
```

I also have [scripts to setup my servers](https://github.com/mohitsinghs/fss).

## Useful commands

- **cleardns** - clear dns cache
- **upblock** - update blocklist
- **upall** - update almost everything I need
- **orphan** - check for brew packages that are not dependencies of others
- **repo** - cd into project repos from anywhere. (with tab completions)

## Contributing

Feel free to help improving this repo by creating issues for bugs or pull requests of things that I've missed.
