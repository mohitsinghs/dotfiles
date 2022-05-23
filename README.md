<h1 align="center">dotfiles</h1>
<p align="center">
  <b>automated configurations</b><br/>
  <sub>for local and remote machines running ubuntu</sub>
</p>
<br />

## Install

### Basic utilities

```bash
# bare minimums
curl -fsSL sh.mohitsingh.in/essential | bash
# dot configs
curl -fsSL sh.mohitsingh.in/shell | bash
# some extra tools that are nice to have
curl -fsSL sh.mohitsingh.in/extra | bash
```

### Languages and Environments

```bash
# node 16.x with yarn
curl -fsSL sh.mohitsingh.in/node | bash
# golang
curl -fsSL sh.mohitsingh.in/go | bash
# python
curl -fsSL sh.mohitsingh.in/python | bash
```

### Cloud Tools

```bash
# docker
curl -fsSL sh.mohitsingh.in/docker | bash
# k3d, kubectl and helm
curl -fsSL sh.mohitsingh.in/kube | bash
# sever config for high load
curl -fsSL sh.mohitsingh.in/highload | bash
```

### VSCodium

```bash
curl -fsSL sh.mohitsingh.in/code | bash
```

## Commands

These are some useful commands/functions

- **`z`** - switch between my local repositories.
- **`upblock`** - update host files to block crap
- **`upall`** - for usual updates
- **`dclean`** - cleanup docker images
- **`muslbuild`** - build current project with musl-libc.
