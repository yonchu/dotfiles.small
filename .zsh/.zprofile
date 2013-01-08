#
#  .zprofile
#

## Terminal background color settings
export COLORFGBG='15;0'
if [ -n "${(M)ITERM_PROFILE#light}" ]; then
  export COLORFGBG='0;15'
elif [ -n "${(M)COLORTERM#gnome-terminal}" ]; then
  export COLORFGBG='0;15'
fi


## Setup profile (common settings)
if [ -f ~/dotfiles/.profile ]; then
    source ~/dotfiles/.profile
fi

## Setup profile profile (chracteristc settings on each OS)
case "${OSTYPE}" in
    # Mac OS X
    darwin*)
    if [ -f ~/dotfiles/.profile.osx ]; then
        source ~/dotfiles/.profile.osx
    fi
    ;;
    # Linux
    linux*)
    if [ -f ~/dotfiles/.profile.linux ]; then
        source ~/dotfiles/.profile.linux
    fi
    ;;
esac


### Complete Messages
echo "Loading .zprofile completed!! (SHELL=${SHELL})"

