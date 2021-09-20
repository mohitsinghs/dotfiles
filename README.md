<h1 align="center">dotfiles</h1>
<p align="center">
  <b>automated configurations</b><br/>
  <sub>for local and remote machines running ubuntu</sub>
</p>
<br />

## Screenshot

![screen](https://user-images.githubusercontent.com/4941333/134054505-832be028-4a65-4714-bc57-0f3cff5828ef.png)

## Install

To install most of the things

```sh
curl -fsSL sh.mohitsingh.in | bash
```

### Basic utilities

```bash
curl -fsSL sh.mohitsingh.in/essential | bash
```

### Shell related configs

```bash
curl -fsSL sh.mohitsingh.in/shell | bash
```

### Neovim configs

```bash
curl -fsSL sh.mohitsingh.in/vim | bash
```

### VSCodium

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

### Cloud

Docker can installed using

```bash
curl -fsSL sh.mohitsingh.in/docker | bash
```

For kubernetes family (kubectl, kubelet and kubeadm) and helm

```
curl -fsSL sh.mohitsingh.in/kube | bash
```

For terraform, terraform-ls and k3d

```bash
curl -fsSL sh.mohitsingh.in/cloud | bash
```

For setting up a ubuntu server with docker and other essentials.

```bash
curl -fsSL sh.mohitsingh.in/server | bash
```

For modifying system limits of remote machines

```bash
curl -fsSL sh.mohitsingh.in/highload | bash
```

### Others

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
