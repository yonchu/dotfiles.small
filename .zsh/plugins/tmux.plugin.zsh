#
# tmux
#

type tmux >/dev/null 2>&1 || { echo '...skip'; return; }

if type tmuxx >/dev/null 2>&1; then
    alias tmx='tmuxx'
fi

alias tm='tmux'
alias tmm='tmux new-session -s main'
alias tmam='tmux attach -t main'
alias tma='tmux attach'
alias tmad='tmux attach -d -t'
alias tml='tmux list-sessions'
alias tmw='tmux list-window'
alias tmc='tmux list-clients'
alias tmrw='tmux rename-window'

