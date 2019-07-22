#!/bin/sh

echo "Welcome to Chase's Computer!"

CONFIG_DIR=${HOME}/.dotfiles

cd $HOME

# Install Homebrew
if ! type "brew" > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew is already installed"
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

# Install tmuxinator
if ! type "tmuxinator" > /dev/null; then
  gem install tmuxinator
else
  echo "Tmuxinator is already installed"
fi

echo "Setup complete for Chase's Computer!"
