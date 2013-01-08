#
# .bash_profile
#

# Source .profile
if [ -f ~/dotfiles/.profile ]; then
    source ~/dotfiles/.profile
fi

# Source .profile.*
case "${OSTYPE}" in
    darwin*)
    if [ -f ~/dotfiles/.profile.osx ]; then
        source ~/dotfiles/.profile.osx
    fi
    ;;
    linux*)
    if [ -f ~/dotfiles/.profile.linux ]; then
        source ~/dotfiles/.profile.linux
    fi
    ;;
esac

# Source .bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

## complete message
echo ".bash_profile load completed...($SHELL)"
