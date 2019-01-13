# dotfiles

> This repository contains my macOS configuration.

### Installing dotfiles

Just run this:

```sh
curl -fsSL install.mohitsingh.in | bash
```

### Setting up Visual Studio Code

```sh
curl -fsSL install.mohitsingh.in/vscode | bash
```

### Setting up Sublime Text

```sh
curl -fsSL install.mohitsingh.in/sublime | bash
```

### Useful commands

- **orphans** - check for brew packages that are not dependencies of others
- **repo** - cd into project repos from anywhere and open them in sublime. (with tab completions)
- **synk** - add/update `.sublime-project` files for all and pre-commit hook for nodejs projects

### Note

> In order to pre-commit hooks to work, **standard**, **babel-eslint**, **prettierx** and **snazzy** need to be installed globally.
