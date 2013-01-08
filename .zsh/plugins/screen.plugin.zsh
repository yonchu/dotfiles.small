#
# screen
#

type screen >/dev/null 2>&1 || { echo '...skip'; return; }

alias sc='screen -U'
alias sl='screen -ls'
alias ssm='screen -U -S main'
alias srm='screen -U -r main'
alias srr='screen -U -D -RR'

