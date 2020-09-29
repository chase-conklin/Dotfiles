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

# Set up Karabiner Elements configuration
ln -s ${CONFIG_DIR}/karabiner ${HOME}/.config

# Install tmuxinator
if ! type "tmuxinator" > /dev/null; then
  gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable
  gem install tmuxinator
  mkdir ${HOME}/.bin
  cd ${HOME}/.bin
  curl -O https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh
else
  echo "Tmuxinator is already installed"
fi

echo "Setup complete for Chase's Computer!"
