#!/bin/zsh

echo "Is this a home computer or work computer? (Enter 'home' or 'work')"
read comptype

if [ $comptype = "work" ] || [ $comptype = "home" ]; then
  echo "Welcome to Chase's Computer!"
else
  echo "That is not a valid type of computer." 1>&2
  exit 1
fi

if [ -d ${HOME}/.dotfiles ]; then
  CONFIG_DIR=${HOME}/.dotfiles
else
  echo "The .dotfiles directory does not exist. Please clone the dotfiles repo into ~/.dotfiles."
  exit 1
fi

cd $HOME

# Check if zsh is the active shell
if [ "$SHELL" != /bin/zsh ]; then
  echo "Please set zsh as the default shell before you continue."
  exit 1
fi

# Remove default zshrc and set up custom version
echo "Setting up .zshrc..."
if [ ! -L ${HOME}/.zshrc ]; then
  rm ${HOME}/.zshrc
  ln -s ${CONFIG_DIR}/zshrc ${HOME}/.zshrc
  source ${HOME}/.zshrc
  echo ".zshrc has been symlinked"
else
  echo ".zshrc has already been symlinked"
fi

# Install Homebrew
echo "Installing Homebrew..."
if ! type "brew" > /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  brew tap homebrew/bundle
  echo "Homebrew has been installed"
else
  echo "Homebrew is already installed"
fi

# Set up Brewfile
echo "Setting up .Brewfile..."
if [ ! -L ${HOME}/.Brewfile ]; then
  ln -s $CONFIG_DIR}/Brewfile ${HOME}/.Brewfile
  echo ".Brewfile has been symlinked"
else
  echo ".Brewfile has already been symlinked"
fi

# Install homebrew bundle to execute the Brewfile
echo "Installing Homebrew dependencies..."
if ! brew bundle check -g --no-upgrade ; then
  brew bundle -g
else
  echo "Homebrew depencies are installed"
fi

# Link vimrc
echo "Setting up .vimrc..."
if [ ! -L ${HOME}/.vimrc ]; then
  rm ${HOME}/.vimrc
  ln -s ${CONFIG_DIR}/vimrc ${HOME}/.vimrc
  echo ".vimrc has been symlinked to the home directory"
else
  echo ".vimrc has already been symlinked"
fi

# Create .config directory if it doesn't exist
if [ ! -d {$HOME}/.config ]; then
  mkdir ${HOME}/.config
fi

# Link starship.toml
echo "Setting up starship.toml..."
if [ ! -L ${HOME}/.config/starship.toml ]; then
  ln -s ${CONFIG_DIR}/starship.toml ${HOME}/.config/starship.toml
  echo "starship.toml has been symlinked to the .config directory"
else
  echo "starship.toml has already been symlinked"
fi

# Set up Neovim
echo "Setting up Neovim..."
if [ ! [ -L {$HOME}/.config/nvim && -d {$HOME}/.config/nvim ] ]; then
  ln -s ${CONFIG_DIR}/nvim ${HOME}/.config
  nvim -c ":PlugInstall | :qa!"
else
  echo "Neovim has already been set up"
fi

# Set up other dotfiles
echo "Setting up other dotfiles..."
if [ ! -L ${HOME}/.gitconfig ]; then
  ln -s ${CONFIG_DIR}/.gitconfig ${HOME}/.gitconfig
  echo ".gitconfig has been symlinked"
else
  echo ".gitconfig has already been symlinked"
fi

if [ ! -L ${HOME}/.gitignore_global ]; then
  ln -s ${CONFIG_DIR}/.gitignore_global ${HOME}/.gitignore_global
  echo ".gitignore_global has been symlinked"
else
  echo ".gitignore_global has already been symlinked"
fi

if [ ! -L ${HOME}/.tmux.conf ]; then
  ln -s ${CONFIG_DIR}/.tmux.conf ${HOME}/.tmux.conf
  echo ".tmux.conf has been symlinked"
else
  echo ".tmux.conf has already been symlinked"
fi

# Set up tmuxinator.zsh
if [ ! -d {$HOME}/.bin ]; then
  mkdir ${HOME}/.bin
fi

if [ ! -L ${HOME}/.bin/.tmuxinator.zsh ]; then
  ln -s ${CONFIG_DIR}/tmuxinator.zsh ${HOME}/.bin/tmuxinator.zsh
else
  echo "Tmuxinator.zsh files is already installed"
fi

# Set up Karabiner Elements configuration
if [ ! [ -L {$HOME}/.config/karabiner && -d {$HOME}/.config ] ]; then
 ln -s ${CONFIG_DIR}/karabiner ${HOME}/.config
else
  echo "Karabiner configuration has already been symlinked"
fi

echo "Setup complete for Chase's Computer!"
