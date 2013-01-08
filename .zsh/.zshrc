#
#  .zshrc
#

setopt prompt_subst
autoload -Uz colors
colors
autoload -Uz add-zsh-hook

## Basic configuration
limit coredumpsize 0
umask 022
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_to_home
setopt correct
setopt correct_all
setopt no_clobber
setopt brace_ccl
setopt print_eight_bit
setopt sh_word_split
setopt multios
setopt noautoremoveslash
setopt no_beep
setopt nolistbeep
setopt equals
setopt no_flow_control
setopt path_dirs
setopt print_exit_value
setopt rm_star_wait
setopt notify
setopt long_list_jobs
setopt auto_resume

REPORTTIME=3

setopt extended_glob
setopt mark_dirs

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

unsetopt promptcr

watch="all"


## Keybind configurations.
bindkey -e
bindkey "^[[3~" delete-char
bindkey '^D' delete-char
bindkey '^T' backward-delete-char
bindkey '^U' backward-kill-line
bindkey '^Y' kill-line
bindkey "^F" forward-word
bindkey "^B" backward-word
bindkey "^W" backward-kill-word
bindkey "^C" send-break

# Unbind for screen and tmux.
bindkey -r "^O"

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /@*?_-.[]~=&;!#$%^(){}<>"
zstyle ':zle:*' word-style unspecified

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

bindkey -a 'q' push-line

# HELP
alias run-help >/dev/null 2>&1 && unalias run-help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svn
bindkey '^@' run-help

# Command line stack.
push_line_and_show_buffer_stack() {
    POSTDISPLAY="
stack: $LBUFFER"
    zle push-line-or-edit
}
zle -N push_line_and_show_buffer_stack
bindkey '^[Q' push_line_and_show_buffer_stack
bindkey '^[q' push_line_and_show_buffer_stack

cdup() {
    if [ -z "$BUFFER" ]; then
        echo
        cd ..
        if type precmd > /dev/null 2>&1; then
            precmd
        fi
        local precmd_func
        for precmd_func in $precmd_functions; do
            $precmd_func
        done
        zle reset-prompt
    else
        zle self-insert '^'
    fi
}
zle -N cdup
bindkey '\^' cdup

pbcopy-buffer(){
    print -rn $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}"
}
zle -N pbcopy-buffer
bindkey '^x^p' pbcopy-buffer


## History configurations
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000
LISTMAX=50
if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST=0
fi

setopt hist_ignore_all_dups
setopt share_history
setopt hist_reduce_blanks
setopt inc_append_history
setopt hist_no_store
setopt hist_no_functions
setopt extended_history
setopt hist_ignore_space
setopt append_history
setopt hist_ignore_space
setopt hist_verify
setopt bang_hist


## Completion configurations
typeset -U fpath
# zsh-completions
fpath=(~/.zsh/functions/Completion/zsh-completions(N-/) ${fpath})
fpath=(~/.zsh/functions/Completion(N-/) ${fpath})

autoload -U compinit
compinit -u -d ~/.zcompdump

setopt list_packed
setopt list_types
setopt auto_list
setopt magic_equal_subst
setopt auto_param_keys
setopt auto_param_slash
setopt chase_links
setopt auto_menu
setopt complete_in_word
setopt always_last_prompt
setopt glob_complete
setopt hist_expand
setopt no_beep
setopt numeric_glob_sort
setopt auto_remove_slash

unset SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))
export SUDO_PATH
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' verbose true

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d:%b'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix

# cd
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*:cd:*' ignore-parents parent pwd ..
typeset -U cdpath
cdpath=($HOME{,/links}(N-/))

# cdr
autoload -U chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file ~/.chpwd-recent-dirs
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":completion:*" recent-dirs-insert both
zstyle ":completion:*:*:cdr:*:*" menu select=2

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcompcache

if [ -n "$LS_COLORS" ]; then
    # LS_COLORSの色と対応
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

setopt complete_aliases

## Terminal configurations.
case "${TERM}" in
    kterm*|xterm*|screen*)
        _change_terminal_title_preexec_hook() {
            if [ "$STY" ]; then
                echo -ne "\ek${1%% *}\e\\"
            fi
        }
        add-zsh-hook preexec _change_terminal_title_preexec_hook

        _change_terminal_title_precmd_hook() {
            if [ "$STY" ]; then
                echo -ne "\ek$(basename $(pwd))\e\\"
            else
                echo -ne "\033]0;$(basename $(pwd))\007"
            fi
            return 0
        }
        add-zsh-hook precmd _change_terminal_title_precmd_hook
        ;;
esac


## Misc
chpwd() {
    ls_abbrev
    # cdd
    type _cdd_chpwd >/dev/null 2>&1 && _cdd_chpwd
}
ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}


# Source plugins.
if [ -d ~/.zsh/plugins ]; then
    for plugin in ~/.zsh/plugins/*.zsh; do
        if [ -f "$plugin" ]; then
            echo "Loading plugin: ${plugin##*/}"
            source "$plugin"
        fi
    done
fi

# Source .alias
if [ -f ~/dotfiles/.alias ]; then
    source ~/dotfiles/.alias
fi

# Source .zalias
#
if [ -f ~/.zsh/.zalias ]; then
    source ~/.zsh/.zalias
fi

# Source .shrc.local
if [ -f ~/dotfiles.local/.shrc.local ]; then
    source ~/dotfiles.local/.shrc.local
fi

path=($path)

### Complete Messages
echo "Loading .zshrc completed!! (ZDOTDIR=${ZDOTDIR})"
echo "Now zsh version $ZSH_VERSION starting!!"

# Print log
log

