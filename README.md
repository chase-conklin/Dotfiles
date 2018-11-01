## Setup

The following commands are all contained in the install.sh file to get my system set up in the event a a clean install of macOS. You will need git installed to clone this repository. The easiest way to install git is to install the XCode Command Line Tools.

```
# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install homebrew bundle to execute the Brewfile
brew tap homebrew/bundle
cp ~/.dotfiles/Brewfile ~
brew bundle --file="$HOME/Brewfile"
rm ~/Brewfile
