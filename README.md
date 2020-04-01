# dotfiles
author(s): khuynh

## Overview
Dotfile management using a bare git repository method (see
[here](https://www.atlassian.com/git/tutorials/dotfiles)).

## Setup
To use this, you need to setup the proper aliases using the following commands:

```bash
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc
```

## Usage

```bash
config status
config add .vimrc
config commit -m 'add vimrc'

config add .bashrc
config commit -m 'add bashrc'
config push
```

## New Machine Setup

* install oh-my-zsh (this is required before setting up the repository, your
  .zshrc will be overwritten later)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

* clone the dotfiles repository onto your machine

```bash
git clone --bare git@github.com:hkennyv/dotfiles.git $HOME/.cfg
```

* define alias for config temporarily

```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

* checkout the actual content from the bare repository into your `$HOME`

```bash
config checkout
```

* configure git

```bash
config config --local status.showUntrackedFiles no
```
