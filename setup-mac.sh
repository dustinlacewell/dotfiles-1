#!/usr/bin/env bash

## License:

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

control_c()
{
  (>&2 printf "\n${RED}Aborting...${NC}\n")
  exit 1
}
 
trap control_c SIGINT

echo "========================================================================"
echo "|                       Ben's macOS Setup Script                       |"
echo "========================================================================"

echo "We'll need sudo permissions temporarily..."
sudo echo "Successfully used sudo!" || exit

# Install homebrew
echo "Installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing wget zsh git stow tmux vim"

brew install wget zsh git stow tmux vim

echo "Installing Hack font"
wget -O font.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip && unzip -j font.zip -d /Library/Fonts/ && rm font.zip

echo "Installing applications..."
brew tap caskroom/cask
brew update
brew cask install iterm2 firefox github keepassxc virtualbox nextcloud thunderbird flux torbrowser github-desktop libreoffice

# Emacs. The one true editor.
echo "Installing Emacs..."
brew install emacs --with-ctags --with-mailutils --with-modules --with-cocoa --with-imagemagick@6 --with-librsvg --with-dbus

# Of course, my Emacs dotfiles!
echo "Installing siraben's dotfiles"
git clone https://github.com/siraben/dotfiles ~/dotfiles
source <(cat ~/dotfiles/install.sh)

# Start in the background for configuration
echo "Installing aspell and Guile."
brew install aspell guile

echo "Starting Emacs in the background..."
emacs --daemon

say "Done!"

# Candidate change to automatically set up irony mode
# IRONY_PATH=`ls -1 ~/.emacs.d/elpa/ | grep ^irony | head -n 1`

# LLVM_CONFIG=`which llvm-config`

# if [ -z $LLVM_CONFIG ]; then
#   echo "llvm-config was not found. trying to find it at /usr/local..."
#   LLVM_CONFIG=`find /usr/local -type f -name llvm-config | head -n 1`
# fi

# LIBCLANG_LIBRARY=`$LLVM_CONFIG --libdir`/libclang.dylib
# LIBCLANG_INCLUDE=`$LLVM_CONFIG --includedir`

# cmake -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
#       -DLIBCLANG_LIBRARY=$LIBCLANG_LIBRARY \
#       -DLIBCLANG_INCLUDE_DIR=$LIBCLANG_INCLUDE \
#       -DCMAKE_INSTALL_PREFIX\=~/.emacs.d/irony/ ~/.emacs.d/elpa/$IRONY_PATH/server &&\
#     cmake --build . --use-stderr --config Release --target install

