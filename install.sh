#!/bin/zsh

# Color Settings
# Reference: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

echo -e "${Green}Welcome to Chase's Computer!${Color_Off}"
sleep 2

if [ -d ${HOME}/.dotfiles ]; then
  CONFIG_DIR=${HOME}/.dotfiles
else
  echo -e "${Red}The .dotfiles directory does not exist. Please clone the dotfiles repo into ~/.dotfiles.${Color_Off}"
  exit 1
fi

cd $HOME

# Check if zsh is the active shell
if [ "$SHELL" != /bin/zsh ]; then
  echo -e "${Red}Please set zsh as the default shell before you continue.${Color_Off}"
  exit 1
fi

# Remove default zshrc and set up custom version
echo -e "Setting up .zshrc..."
sleep 2
if [ ! -L ${HOME}/.zshrc ]; then
  rm ${HOME}/.zshrc
  ln -s ${CONFIG_DIR}/zshrc ${HOME}/.zshrc
  source ${HOME}/.zshrc
  echo -e "${Green}.zshrc has been symlinked${Color_Off}"
else
  echo -e "${Red}.zshrc has already been symlinked${Color_Off}"
fi

# Install Homebrew
echo -e "Installing Homebrew..."
sleep 2
if ! type "brew" > /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/chase.conklin/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew tap homebrew/bundle
  echo -e "${Green}Homebrew has been installed${Color_Off}"
else
  echo -e "${Red}Homebrew is already installed${Color_Off}"
fi

# Set up Brewfile
echo -e "Setting up .Brewfile..."
sleep 2
if [ ! -L ${HOME}/.Brewfile ]; then
  cp ${CONFIG_DIR}/Brewfile ${CONFIG_DIR}/Brewfile.local
  ln -s ${CONFIG_DIR}/Brewfile.local ${HOME}/.Brewfile
  echo -e "${Green}.Brewfile has been symlinked${Color_Off}"
else
  echo -e "${Red}.Brewfile has already been symlinked${Color_Off}"
fi

# Install homebrew bundle to execute the Brewfile
echo -e "Installing Homebrew dependencies..."
sleep 2
if ! brew bundle check -g --no-upgrade ; then
  brew bundle install -g
else
  echo -e "${Green}Homebrew depencies are installed${Color_Off}"
fi

# Link vimrc
echo -e "Setting up .vimrc..."
sleep 2
if [ ! -L ${HOME}/.vimrc ]; then
  rm ${HOME}/.vimrc
  ln -s ${CONFIG_DIR}/vimrc ${HOME}/.vimrc
  echo -e "${Green}.vimrc has been symlinked to the home directory${Color_Off}"
else
  echo -e "${Red}.vimrc has already been symlinked${Color_Off}"
fi

# Create .config directory if it doesn't exist
if [[ ! -d ${HOME}/.config ]]; then
  mkdir ${HOME}/.config
fi

# Link starship.toml
echo -e "Setting up starship.toml..."
sleep 2
if [ ! -L ${HOME}/.config/starship.toml ]; then
  ln -s ${CONFIG_DIR}/starship.toml ${HOME}/.config/starship.toml
  echo -e "${Green}starship.toml has been symlinked to the .config directory${Color_Off}"
else
  echo -e "${Red}starship.toml has already been symlinked${Color_Off}"
fi

# Set up Neovim
echo -e "Setting up Neovim..."
sleep 2
if [[ ! -L ${HOME}/.config/nvim ]]; then
  ln -s ${CONFIG_DIR}/nvim ${HOME}/.config
  nvim -c ":source ~/.vimrc | :PlugInstall | :qa!"
  echo -e "${Green}Neovim setup has been completed${Color_Off}"
else
  echo -e "${Red}Neovim has already been set up"${Color_Off}
fi

# Set up other dotfiles
echo -e "Setting up other dotfiles..."
sleep 2

cp ${CONFIG_DIR}/gitconfig ${HOME}/.gitconfig

if [ ! -L ${HOME}/.gitignore_global ]; then
  ln -s ${CONFIG_DIR}/gitignore_global ${HOME}/.gitignore_global
  echo -e "${Green}.gitignore_global has been symlinked${Color_Off}"
else
  echo -e "${Red}.gitignore_global has already been symlinked${Color_Off}"
fi

# Set up Karabiner Elements configuration
echo -e "Setting up Karabiner configuration"
sleep 2
if [[ ! -L {$HOME}/.config/karabiner ]]; then
  mkdir ~/.config/karabiner
  ln -s ${CONFIG_DIR}/karabiner.json ${HOME}/.config/karabiner
  echo -e "${Green}Karabiner configuration has been set up${Color_Off}"
else
  echo -e "${Red}Karabiner configuration has already been symlinked${Color_Off}"
fi

sleep 2
echo -e "${Green}Setup complete for Chase's Computer!${Color_Off}"
