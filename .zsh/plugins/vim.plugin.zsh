#
# Vim
#

if [ -x /Applications/MacVim.app/Contents/MacOS/Vim ]; then
    # MacVim-Kaoriya
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vimm='/usr/bin/vim'
    #alias ctags='/Applications/MacVim.app/Contents/MacOS/ctags "$@"'
    alias view='vim -R'
elif type vim > /dev/null 2>&1; then
    alias vi='vim'
    alias view='vim -R'
else
    alias vim='vi'
fi

# vim less
if [ -x /Applications/MacVim.app/Contents/Resources/vim/runtime/macros/less.sh ]; then
    alias vless='/Applications/MacVim.app/Contents/Resources/vim/runtime/macros/less.sh'
elif [ -x /usr/share/vim/vim73/macros/less.sh ]; then
    alias vless='/usr/share/vim/vim73/macros/less.sh'
fi

