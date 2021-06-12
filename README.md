<h1 align="center">dotfiles</h1>
<p align="center">
  <b>automated configurations</b><br/>
  <sub>for local and remote machines running ubuntu</sub>
</p>
<br />

## Install

To install most of the things

```sh
curl -fsSL sh.mohitsingh.in | bash
```

## Overview

### Basics

- zsh with pure prompt, zsh-syntax-highlighting, zsh-autosuggestions instead of bash
- jq for json processing
- tmux for terminal multiplexing
- htop for monitoring system resources
- unstable neovim replaces vim
- aria2 replaces wget
- httpie replaces curl
- ripgrep replaces grep
- bat replaces cat
- exa replaces ls
- delta for diff highlighting
- latest git ppa
- some archiving and compression tools
- python3

These can be installed by running

```bash
curl -fsSL sh.mohitsingh.in/essential | bash
```

For shell related configs

```bash
curl -fsSL sh.mohitsingh.in/shell | bash
```

and, for neovim configs

```bash
curl -fsSL sh.mohitsingh.in/vim | bash
```

### VSCodium

Although, my primary editor is neovim, I switch between that and VSCodium. For installing VSCodium along with extensions and configs I use

```bash
curl -fsSL sh.mohitsingh.in/code | bash
```

### Languages

For installing node 16.x

```bash
curl -fsSL sh.mohitsingh.in/node | bash
```

To install or upgrade golang

```bash
curl -fsSL sh.mohitsingh.in/go | bash
```

For rust I use [rustup](https://rustup.rs/)

### Databases

PostgreSQL is my favorite database, that along with MySQL can be installed using

```bash
curl -fsSL sh.mohitsingh.in/databases | bash
```

Normally, I prefer docker for using databases.

### Cloud

Docker can installed using

```bash
curl -fsSL sh.mohitsingh.in/docker | bash
```

For kubernetes family (kubectl, kubelet and kubeadm) and helm

```
curl -fsSL sh.mohitsingh.in/kube | bash
```

I provision my infra with terraform and use k3d for local kubernetes cluster both of which can be installed using

```bash
curl -fsSL sh.mohitsingh.in/cloud | bash
```

### More on cloud

I've a script for initial setup of my remote machines which handles creating a user with my name, installing docker and setting up essential tools on server along with my shell.

```bash
curl -fsSL sh.mohitsingh.in/server | bash
```

For modifying system limits of remote machines I use

```bash
curl -fsSL sh.mohitsingh.in/highload | bash
```

### Finally

Some useful utilities

```bash
curl -fsSL sh.mohitsingh.in/extra | bash
```

### Scripts

All the scripts can be found in [/scripts](/scripts) directory.

## Commands

These are some useful commands/functions

- **`repo`** - switch between my local repositories.
- **`upblock`** - update host files to block crap
- **`upall`** - for usual updates
- **`dclean`** - cleanup docker images
