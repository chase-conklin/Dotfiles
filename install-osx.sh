#!/bin/sh

echo "Welcome to Chase's Computer!"

CONFIG_DIR=${HOME}/.dotfiles

cd $HOME

# Install Homebrew
if ! type "brew" > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install homebrew bundle to execute the Brewfile
brew tap homebrew/bundle
if ! brew bundle check --file=~/.dotfiles/Brewfile --no-upgrade ; then
  brew bundle --file=${CONFIG_DIR}/Brewfile
else
  echo "Homebrew depencies are installed"
fi

# Link vimrc and install vim plugins
ln -s ${CONFIG_DIR}/.vimrc ${HOME}/.vimrc
vim -c ":qa"

# Set zsh to default
chsh -s $(which zsh);

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s ${CONFIG_DIR}/.zshrc.osx ${HOME}/.zshrc

# Install Spacehip Theme
git clone https://github.com/denysdovhan/spaceship-prompt.git "${ZSH_CUSTOM}/themes/spaceship-prompt"
ln -s "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme"

# Set up dotfiles
ln -s ${CONFIG_DIR}/.gitconfig ${HOME}/.gitconfig
ln -s ${CONFIG_DIR}/.gitignore_global ${HOME}/.gitignore_global
ln -s ${CONFIG_DIR}/.tmux.conf ${HOME}/.tmux.conf

# Install tmuxinator
gem install tmuxinator

echo "Setup complete for Chase's Computer!"
