#!/bin/sh

echo "Welcome to Chase's Computer!"

cd ~

# Install Homebrew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install homebrew bundle to execute the Brewfile
brew tap homebrew/bundle
cp ~/.dotfiles/Brewfile ~
brew bundle --file="$HOME/Brewfile"
rm ~/Brewfile
