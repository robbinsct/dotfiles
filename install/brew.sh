#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing homebrew packages..."

# cli tools
brew install ack
brew install tree
brew install wget

# development tools
brew install git
brew install hub
brew install reattach-to-user-namespace
brew install tmux
brew install zsh
#brew install highlight
brew install nvm
#brew install z
#brew install markdown

# install neovim
#brew tap neovim/neovim
#brew install --HEAD neovim

