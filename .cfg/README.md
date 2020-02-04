# dotfiles
author(s): khuynh

## Overview
Dotfile management using a bare git repository method (see
[here](https://www.atlassian.com/git/tutorials/dotfiles).

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
