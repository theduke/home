#! /bin/bash

echo "Installing..."

BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR="$(dirname $BIN_DIR)"

# Copy files in ~.
for FILE in ".Xresources" ".zshrc"
do
  if [ ! -f "$HOME/$FILE" ]; then
    ln -s "$DIR/$FILE" "$HOME/$FILE"
   fi
done

# Copy files in ~/.config.
for FILE in ".config/i3/config" ".config/terminator/config" ".config/gtk-3.0/settings.ini"
do
  PARENT=$(dirname $FILE)
  if [ ! -d "$HOME/$PARENT" ]; then
    echo "Creating directory $HOME/$PARENT"
    mkdir -p "$HOME/$PARENT" 
  fi
  if [ ! -f "$HOME/$FILE" ]; then
    echo "Symlinking file $HOME/$FILE"
    ln -s "$DIR/$FILE" "$HOME/$FILE"
  fi
done


