# dotfiles

author(s): khuynh

## Overview

Dotfile management using a bare git repository method (see
[here](https://www.atlassian.com/git/tutorials/dotfiles)).

- [New Machine Setup](#new-machine-setup)
- [Mac OS Setup](#mac-os-setup)
- [Ubuntu Setup](#ubuntu-setup)
- [Windows Setup](#windows-setup)
- [Usage](#usage)

## New Machine Setup

### Install ssh-key

This section is mostly optional, you can always clone over https, but it's
recommended to setup your ssh key.

- create a new ssh-key

```
ssh-keygen -t rsa -b 4096
```

- print ssh key and copy to the clipboard

```
cat ~/.ssh/id_rsa.pub
```

- add your ssh key to [github](https://github.com/settings/keys)

### Setup shell and dotfiles

The following instructions works for any new UNIX-like machine. We will use
`zsh` and configure it using [`oh-my-zsh`](https://ohmyz.sh/). If you don't
wish to use `zsh` and prefer to use an alternative shell, you can skip the
first step below.

- install oh-my-zsh (this is required before setting up the repository, your
  .zshrc will be overwritten later)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- clone the dotfiles repository onto your machine

```bash
git clone --bare git@github.com:hkennyv/dotfiles.git $HOME/.cfg
```

- define alias for config temporarily

```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

- checkout the actual content from the bare repository into your `$HOME`
  directory

```bash
config checkout
```

- configure git to ignore untracked files

```bash
config config --local status.showUntrackedFiles no
```

- check the dotfiles were cloned and checked out correctly. run the following
  command and your output should confirm you are on the `master` branch
  with no new commits

```
config status
```

your output should match something along these lines (ensure your current
working directory is \$HOME):

```
On branch master
nothing to commit (use -u to show untracked files)
```

After successfully setting up the shell, see the OS specific instructions to
get started installing some applications.

## Mac OS Setup

### Install brew

- [brew](https://brew.sh/)

Install brew using the following:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

- update brew formulae and brew

```
brew update
```

### Install packages and applications

- install brew bundle

```
brew tap Homebrew/bundle
```

- install the `.Brewfile`. this will install all of the packages and cask
  applications listed in the file. i've included the packages and applications
  i use daily along with some qol packages (e.g. ripgrep to replace grep, fzf,
  etc...). I've included a seperate brewfile for some SDL dependencies that
  you can also install if you wish.

Use the following command to install the `.Brewfile`:

```
brew bundle --file $HOME/.khuynh/Brewfile
```

This will install the following **packages** (check the file in the repository
for the most up to date list):

- python3, pip3
- node
- yarn
- fzf
- rg

and the following **applications**:

- iterm2 terminal emulator
- rectangle wm
- discord
- slack
- transmission torrent client

- vim 8.0+

check the version of vim with `vim --version` and install with brew if version
is less than 8.0.

### Other useful programs

- [rustup](https://www.rust-lang.org/tools/install)
- [vscode insiders](https://code.visualstudio.com/insiders/) (to uninstall the
  stable version that is installed with the `.Brewfile`, delete `Visual Studio Code.app`)
- [XCode](https://developer.apple.com/download/more/) - you want to install
  both XCode and the Command Line Tools for XCode

### Vim setup

- install [vim-plug](https://github.com/junegunn/vim-plug) vim package manager

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

- open vim and run `:PlugInstall` to install all the plugins listed in your
  `.vimrc`

## Ubuntu Setup

- update apt

```bash
sudo apt update && sudo apt -y upgrade
```

- install git

Install git using the following:

```bash
sudo apt install git
```

- install zsh

```bash
sudo apt install zsh
```

- follow the instructions for [setting up your shell](#setup-shell-and-dotfiles)
  to get setup with zsh

- create ssh key and add to git

```bash
ssh-keygen -b 4096 -t rsa
```

- add ssh key to github [here](https://github.com/settings/keys)

```bash
cat ~/.ssh/id_rsa.pub
```

- install packages from `.khuynh/packages.txt`

```bash
cat ~/.khuynh/packages.txt | xargs sudo apt install -y
```

## Windows Setup

### Ninite install

Head over to <https://ninite.com/> and select the following programs:

- chrome
- teamviewer
- windirstat
- winscp
- vlc
- qbittorrent
- malwarebytes
- steam

Run the ninite installer to have all the programs installed.

### Install WSL

Follow the instructions [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
to install Windows Subsystem for Linux (WSL). I prefer Ubuntu 20.04 LTS.

From here, follow the instructions in [Ubuntu Setup](#ubuntu-setup).

### Install MSYS2

Follow instructions to install [MSYS2](https://www.msys2.org/) to get a proper
unix(ish) shell environment set up.

#### Update MSYS2 path to include windows path

Open to `C:\msys64\msys2_shell.cmd` and edit the file to uncomment the line:

```
rem set MSYS2_PATH_TYPE=inherit
```

to

```
set MSYS2_PATH_TYPE=inherit
```

This will bring inherit your windows path into your MSYS2 PATH. You can verify
this by using the following command in your MSYS2 shell (after you restart it):

```
echo $PATH
```

### Toolchain setup

#### Python

#### Node.js

#### Rust

### THIS SECTION IS A WIP

For windows setups, there are a few ways to get a UNIX-like environment. I
prefer to configure [MSYS2](https://www.msys2.org/) on my windows machines.
Some alternatives include
[WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10),
[Cygwin](https://www.cygwin.com/), and more.

## Usage

### Configuration

Although this installation targets zsh, you can use it with any shell. Simply
source the following files:

- `.aliases` - contains all aliases
- `.profile` - modifies \$PATH, don't add user-specific paths in here, use
  `.profile.local` to do that
- `.profile.local` - user-specific \$PATH modifications

Application specific configuration include:

- `.vimrc` - user vim configuration
- `.zshrc` - zsh configuration

### Commands

Inside of `.aliases`, we have:

```
alias config="$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME"
```

It essentially aliases `config` to `git`. To add/modify/remove files from
this git repo, you can use pretty much any regular git command except
substite `git` for `config`. See the example of adding a `.vimrc` below:

```bash
config status
config add .vimrc
config commit -m 'add vimrc'

config add .bashrc
config commit -m 'add bashrc'
config push
```
