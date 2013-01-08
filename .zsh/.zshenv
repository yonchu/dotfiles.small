#
#  .zshenv
#
#

ZDOTDIR=$HOME/.zsh

limit coredumpsize 0
typeset -U path

# rsync
export RSYNC_RSH=ssh

# CVS
export CVS_RSH=ssh
export CVSROOT=~/CVSROOT

