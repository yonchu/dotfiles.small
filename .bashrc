#
# .bashrc
#

# If not running interactively, don't do anything.
test -z "$PS1" && return

# Source global definitions.
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Permission 644.
if [ $UID -ne 0 ]; then
    umask 022
fi

# Restrict overwrite by redirection.
set -o noclobber

complete -d cd

# history setting
bind '"\e[A": history-search-backward'
bind '"\e[0A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[0B": history-search-forward'


#
# Source .alias
#
if [ -f ~/dotfiles/.alias ]; then
    source ~/dotfiles/.alias
fi

#
# Source local settings
#
if [ -f ~/dotfiles.local/.shrc.local ]; then
    source ~/dotfiles.local/.shrc.local
fi


## complete message
echo ".bashrc load completed..."
echo "Now bash version $BASH_VERSION start!"

