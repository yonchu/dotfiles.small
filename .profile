#
#  .profile
#

# LANG
export LANG=ja_JP.UTF-8
case ${UID} in
    0)
        LANG=C
        ;;
esac

# User Local Directory.
USER_LOCAL=/usr/local
if type brew > /dev/null 2>&1; then
    USER_LOCAL=$(brew --prefix)
fi
export USER_LOCAL


# Terminal configuration.
case "${TERM}" in
    xterm)
        export TERM=xterm-color
        ;;
    kterm)
        export TERM=kterm-color
        # Set BackSpace control character.
        stty erase
        ;;
esac

# LSCOLORS, LS_COLORS
unset LSCOLORS
case "${TERM}" in
    xterm*|screen*)
        export CLICOLOR=1
        export LSCOLORS=DxGxcxdxCxegedabagacad

        LS_COLORS="no=00:fi=00:di=36:ln=35:pi=30;44:so=35;44:do=35;44"
        LS_COLORS="${LS_COLORS}:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41"
        LS_COLORS="${LS_COLORS}:ex=01;31:su=41;30:sg=46;30:tw=42;30:ow=43;30"
        export LS_COLORS

        if [ -f ~/.dir_colors ]; then
            if type dircolors > /dev/null 2>&1; then
                eval $(dircolors ~/.dir_colors)
            elif type gdircolors > /dev/null 2>&1; then
                eval $(gdircolors ~/.dir_colors)
            fi
        fi
        ;;
    kterm*)
        export LSCOLORS=exfxcxdxbxegedabagacad
        LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30"
        LS_COLORS="${LS_COLORS}:sg=46;30:tw=42;30:ow=43;30"
        export LS_COLORS
        ;;
    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad
        LS_COLORS="di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34"
        LS_COLORS="${LS_COLORS}:su=41;30:sg=46;30:tw=42;30:ow=43;30"
        export LS_COLORS
        ;;
    jfbterm-color)
        export LSCOLORS=gxFxCxdxBxegedabagacad
        LS_COLORS="di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34"
        LS_COLORS="${LS_COLORS}:su=41;30:sg=46;30:tw=42;30:ow=43;30"
        export LS_COLORS
        ;;
esac

# history setting
HISTSIZE=10000
HISTFILESIZE=100000
HISTCONTROL=ignoredups
HISTTIMEFORMAT='%Y-%m-%d %T '
export HISTSIZE HISTFILESIZE HISTCONTROL HISTTIMEFORMAT

# PAGER
export PAGER=less

# less
export LESS='-R -X -i -x4 --LONG-PROMPT'
export JLESSCHARSET=japanese-utf-8
export LESSCHARSET=utf-8
export GIT_PAGER="less -F"

# EDITOR, VISUAL
export EDITOR=vim
export VISUAL=vim

# grep
GREP_OPTIONS="-I --directories=skip --color=auto"
export GREP_OPTIONS
export GREP_COLOR='1;37;41'

# BLOCKSIZE
export BLOCKSIZE=k

# rsync
#export RSYNC_PASSWORD=xxxx
export RSYNC_RSH=ssh

# tree
export TREE_CHARSET='UTF-8'
export LC_CTYPE='ja_JP.UTF-8'

# CVS
export CVS_RSH=ssh
export CVSROOT=~/CVSROOT

# Subversion
export SVN_EDITOR=vim

# Git
export GIT_EDITOR=/usr/bin/vim


### Complete Messages
echo "Loading .profile completed!!"

