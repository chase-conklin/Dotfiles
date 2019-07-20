#!/bin/sh

echo "Welcome to Chase's Computer!"

CONFIG_DIR=${HOME}/.dotfiles

cd $HOME

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install homebrew bundle to execute the Brewfile
brew tap homebrew/bundle
brew bundle --file=${CONFIG_DIR}/Brewfile

# Link vimrc and install vim plugins
ln -s ${CONFIG_DIR}/.vimrc ${HOME}/.vimrc
vim +PlugInstall

# Set zsh to default
chsh -s $(which zsh);

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Spacehip Theme
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Set up dotfiles
ln -s ${CONFIG_DIR}/.zshrc.osx ${HOME}/.zshrc
ln -s ${CONFIG_DIR}/.gitconfig ${HOME}/.gitconfig
ln -s ${CONFIG_DIR}/.gitignore_global ${HOME}/.gitignore_global
ln -s ${CONFIG_DIR}/.tmux.conf ${HOME}/.tmux.conf

# Install tmuxinator
gem install tmuxinator

echo "Setup complete for Chase's Computer!"
