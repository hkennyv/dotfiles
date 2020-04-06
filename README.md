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

## Mac OS Setup

### Installation

* [brew](https://brew.sh/)

Install brew using the following:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

* install brew bundle

```
brew tap Homebrew/bundle
```

* install the `.Brewfile`

Use the following command to install the `.Brewfile`:

```
brew bundle --file .Brewfile
```

This will install the following **binaries**:

* python3, pip3
* node
* yarn
* fzf
* rg

and the following **applications**:

* iterm2 terminal emulator
* rectangle wm
* discord
* slack
* transmission torrent client

* vim 8.0+

check the version of vim with `vim --version` and install with brew if version
is less than 8.0.

* [vscode insiders](https://code.visualstudio.com/insiders/)


### Steps

* follow the [new machine setup](#new-machine-setup)
* install [vim-plug](https://github.com/junegunn/vim-plug)

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

* open vim and run `:PlugInstall`
