# My Dotfile Configuration

This is my dotfile configuration for Mac. I am hoping to add the ability for these files to adapt whether they are being installed on a Mac or Linux machine.

## Prequisites

### Install Xcode Command Line Tools

For a brand new machine or a fresh macOS install, you will need to install Xcode Command Line Tools.

Open Terminal.app and enter the following command:

```xcode-select --install```

This will install git which will allow the ability to clone the repo from Github.

If the computer is not brand new then you can check if git is already installed by just executing:

```git```

### Clone the Repository

The repository must be cloned to ```~/.dotfiles``` directory in order for the install script to function properly. This is the directory name that made the most sense to me.

## Installation

Once the repository has been cloned, the install script can be executed:

```/bin/zsh install.sh```

TODO: Include list of preferred development technologies and applications.