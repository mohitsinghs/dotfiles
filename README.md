# dotfiles

> My macOS configuration

## Usage

To install everything except VSCodium

```sh
curl -fsSL sh.mohitsingh.in | bash
```

## Modules

> You can also setup things one by one

To setup brew with packages I use

```sh
curl -fsSL sh.mohitsingh.in/brew | bash
```

To install **pure prompt** with **neovim** and **coc.nvim**

> Please make sure you have node installed before running this independently

```sh
curl -fsSL sh.mohitsingh.in/shell | bash
```

To install VSCodium with extensions

```
curl -fsSL sh.mohitsingh.in/vscode | bash
```

## Useful commands

- **orphan** - check for brew packages that are not dependencies of others
- **repo** - cd into project repos from anywhere. (with tab completions)

## Screenshots

---

![](https://user-images.githubusercontent.com/4941333/67544882-ca7b5e00-f714-11e9-884e-becc97b5d98a.png 'zsh with pure prompt')
![](https://user-images.githubusercontent.com/4941333/67544883-cb13f480-f714-11e9-8c68-cc841b9fa35e.png 'neovim running inside tmux')

## Contributing

Feel free to help improving this repo by creating issues for bugs or pull requests of things that I've missed.
