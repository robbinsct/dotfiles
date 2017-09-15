#!/bin/bash

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

echo "Linking dotfiles"
source install/link.sh

if [ "$(uname)" == "Darwin" ]; then
    echo "Running on OSX"

    echo "Brewing all the things"
    source install/brew.sh

    echo "blurp.."

    echo "Updating OSX settings"
    source installosx.sh

    echo "Installing node (from nvm)"
    source install/nvm.sh
fi

echo "Configuring zsh as default shell"
chsh -s $(which zsh)

echo "Done."
