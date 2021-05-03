#!/bin/sh

if [ $1 = "work" ] || [ $1 = "personal" ]; then
  echo "Welcome to Chase's Computer!"
else
  echo "That is not a valid directory." 1>&2
  exit 1
fi

if [ ! -d ${HOME}/.dot]; then
  CONFIG_DIR=${HOME}/.dot/$1
else
  echo "The .dot directory does not exist. Please clone the dotfiles repo into ~/.dot."
  exit 1
fi

cd $HOME

# Install Homebrew
if ! type "brew" > /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Homebrew is already installed"
fi

# Install homebrew bundle to execute the Brewfile
brew tap homebrew/bundle
if ! brew bundle check --file=${CONFIG_DIR}/Brewfile --no-upgrade ; then
  brew bundle --file=${CONFIG_DIR}/Brewfile
else
  echo "Homebrew depencies are installed"
fi

# Link vimrc and install vim plugins
rm ${HOME}/.vimrc
ln -s ${CONFIG_DIR}/.vimrc ${HOME}/.vimrc
vim -c ":PlugInstall | :qa"

# Set zsh to default
if [ "$SHELL" != /bin/zsh ]
then
  chsh -s $(which zsh);
else
  echo "Zsh is already the default shell"
fi

# Install Oh-My-Zsh
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "Oh-My-Zsh is already installed"
fi

# Remove default zshrc and set up custom version
rm ${HOME}/.zshrc
ln -s ${CONFIG_DIR}/.zshrc.osx ${HOME}/.zshrc

# Install Spacehip Theme
if [ ! -d "${HOME}/.oh-my-zsh/custom/themes/spaceship-prompt" ]; then
  git clone https://github.com/denysdovhan/spaceship-prompt.git "${ZSH_CUSTOM}/themes/spaceship-prompt"
else
  echo "Spaceship theme is already installed"
fi

ln -s "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme"

# Set up dotfiles
ln -s ${CONFIG_DIR}/.gitconfig ${HOME}/.gitconfig
ln -s ${CONFIG_DIR}/.gitignore_global ${HOME}/.gitignore_global
ln -s ${CONFIG_DIR}/.tmux.conf ${HOME}/.tmux.conf

# Set up tmuxinator.zsh
mkdir ${HOME}/.bin
ln -s ${CONFIG_DIR}/tmuxinator.zsh ${HOME}/.bin/tmuxinator.zsh

# Set up Karabiner Elements configuration
mkdir ${HOME}/.config
cd ${HOME}/.config
ln -s ${CONFIG_DIR}/karabiner
cd ${HOME}

echo "Setup complete for Chase's Computer!"
