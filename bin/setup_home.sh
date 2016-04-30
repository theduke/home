#! /bin/bash

echo "Installing..."

BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR="$(dirname $BIN_DIR)"

if [ ! -d "$HOME/tmp" ]; then
  echo "Creating user tmp dir at $HOME/tmp"
  mkdir $HOME/tmp
fi
cd $HOME/tmp

# Link files in ~.
for FILE in ".Xresources" ".zshrc"
do
  if [ ! -L "$HOME/$FILE" ]; then
    ln -s "$DIR/$FILE" "$HOME/$FILE"
    echo "Symlinking file $HOME/$FILE"
  fi
  unset FILE
done

# Link files in ~/.config.
for FILE in ".config/i3/config" ".config/terminator/config" ".config/gtk-3.0/settings.ini"
do
  PARENT=$(dirname $FILE)
  if [ ! -d "$HOME/$PARENT" ]; then
    echo "Creating directory $HOME/$PARENT"
    mkdir -p "$HOME/$PARENT" 
  fi
  if [ ! -L "$HOME/$FILE" ]; then
    echo "Symlinking file $HOME/$FILE"
    ln -s "$DIR/$FILE" "$HOME/$FILE"
  fi
done

# Link bin dir.
if [ ! -d "$HOME/bin" ]; then 
  echo "Creating dir $HOME/bin"
  mkdir $HOME/bin
fi
for FILE in $(ls $BIN_DIR)
do
  # Ignore setup file.
  if [ $FILE == "setup_home.sh" ]; then
    continue
  fi
  if [ ! -L "$HOME/bin/$FILE" ]; then
    echo "Symlinking file $HOME/bin/$FILE"
    ln -s "$DIR/bin/$FILE" "$HOME/bin/$FILE"
  fi
done

if [ ! -d "$HOME/.local/share/fonts" ]; then
  echo "Downloading fonts."
  mkdir -p "$HOME/.local/share/fonts"
fi
  
if [  ! -f "$HOME/.local/share/fonts/System San Francisco Display Regular.ttf" ]; then 
  echo "Downloading Yosemite San Francisco font"
  curl -LO https://github.com/supermarin/YosemiteSanFranciscoFont/archive/master.zip
  unzip master.zip
  mv YosemiteSanFranciscoFont-master/*.ttf $HOME/.local/share/fonts/
fi

echo "All done."

