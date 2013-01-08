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


## Aliased
# $ alias [command]
# $ type [-a] <command>
# $ \cmd
# $ command cmd
# $ declare
# $ declare -f <function>

alias where="command -v"
alias jl="jobs -l"
alias cl='clear'
alias quit='exit';


# ls
case "${OSTYPE}" in
    freebsd*|darwin*)
        if type gls > /dev/null 2>&1; then
            alias ls='gls -aFhv --color=auto --show-control-chars'
            alias ll='ls -l --time-style=long-iso'
        else
            alias ls='ls -aFGhv'
            alias ll='ls -lT'
        fi
        ;;
    linux*)
        alias ls='ls -aFh --color=auto'
        alias ll='ls -l'
        ;;
esac
alias lld='ls -d'
alias llt='ll -rt'
alias lll='ll | less'


# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cdp='cd -P'
alias cdl='cd -L'

# pwd
alias pwd='pwd -P'

# df, du
alias df='df -h'
alias du='du -h'
alias dus='du -s'

# mv, rm, cp
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -ir'

alias mvi='mv -i'
alias rmi='rm -i'
alias cpi='cp -ir'

# cp
alias cpa='cp -a'

# grep
if grep --help 2> /dev/null | grep -q -- --exclude-dir; then
    alias gre='grep -niE --exclude-dir=.svn --exclude-dir=.git'
else
    alias gre='grep -niE'
fi
alias grepr='gre -R'

grepv () {
    grep "$@" | vim -R -
}


# find
alias findbig='find . -type f -exec ls -s {} \; | sort -n -r | head -5'
alias findmod='find . -type f -mmin -10'
alias lsthumbs='find . -type f -name 'Thumbs.db' -print0 | gxargs -0 ls -a'
alias delthumbs='find . -type f -name 'Thumbs.db' -print0 | gxargs -0 rm -f'

# history
alias h='history 32'
history_all() { history -E 1 | less; }

# od
alias od='od -tx1 -Ax -v'
alias oc='od -c'

# chmod
#  644 rw-r--r--  User file
#  755 rwxr-xr-x  Directory
alias 644='chmod 644'
alias 755='chmod 755'

# ps
alias psa='ps auxw'

# top (for FreeBSD/Mac)
alias topm='top -o rsize'
alias topc='top -R -F -u'

# diff
alias diff='diff -tbBE'
alias diffr='diff -rq'

# curl
alias cur='curl -OLv'

# rsync
alias rsyncz='rsync -avzu'

# Japanese env
alias utf='export LANG=ja_JP.UTF-8; export LANGUAGE=ja_JP.UTF-8; export LC_ALL=ja_JP.UTF-8'
alias en='export LANG=en; export LANGUAGE=en; export LC_ALL=en'

# iptables
alias liptables='iptables -L -n --line-numbers'

# sudo
alias ssu='sudo -s'

# PATH
alias printpath='echo $PATH | tr ":" "\n"'
alias organize_path='tr ":" "\n" | uniq | paste -d: -s -'

# lv
alias lv='lv -cl'

# tree
alias tree='tree -N'

# ack
alias acka='ack -a'
alias ackn='ack -n'

ackv () {
    ack "$@" | vim -R -
}

# nkf
alias nkfg='nkf -g'

utf8() {
    for i in "$@"; do
        nkf -w -Lu $i >! /tmp/euc.$$
        mv -f /tmp/utf8.$$ $i
    done
}
euc() {
    for i in "$@"; do
        nkf -e -Lu $i >! /tmp/euc.$$
        mv -f /tmp/euc.$$ $i
    done
}

sjis() {
    for i in "$@"; do
        nkf -s -Lw $i >! /tmp/euc.$$
        mv -f /tmp/euc.$$ $i
    done
}

# rmtrash
alias rmt='rmtrash'


## complete message
echo ".bashrc load completed..."
echo "Now bash version $BASH_VERSION start!"

