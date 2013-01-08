#!/bin/bash

set -u

confirm_exe() {
    echo -n "$1 (y/n) --> "
    read yn
    case $yn in
        y|Y)
            echo 'Running...'
            return 0
            ;;
        *)
            echo 'Aborted.'
            return 1
            ;;
    esac
}

setup_osx() {
    [ $(uname -s) != 'Darwin' ] && return

    # Show the ~/Library folder
    chflags nohidden ~/Library/

    # Mute system audio
    sudo nvram SystemAudioVolume=%80
}

create_dotfiles() {
    (
        if [ ! -e ~/dotfiles ]; then
            cd ~/
            git clone https://github.com/yonchu/dotfiles.small.git dotfiles
        fi
        cd ~/dotfiles
        git submodule update --init
        [ $? -ne 0 ] && return 1
        git submodule foreach "git checkout master"
    )
}

create_symlink() {
  if [ -e "$2" ]; then
    echo "Already exists: $file"
  else
    ln -s "$1" "$2"
    echo "Create the symbolic link: $file"
  fi
}

create_dotfiles_symlinks() {
    DOT_FILES=(.bash_profile
        .bashrc
        .gitconfig
        .inputrc
        .lv
        .my.cnf
        .screenrc
        .tmux.conf
        .vim
        .vimrc
        .zsh)

    for file in ${DOT_FILES[@]}; do
        create_symlink "$HOME/dotfiles/$file" "$HOME/$file"
    done

    # .zshenv
    ln -s "$HOME/.zsh/.zshenv" "$HOME/.zshenv"

    # .gitignore
    ln -s "$HOME/dotfiles/.gitignore.default" "$HOME/.gitignore"

    # .dir_colors
    ln -s "$HOME/.zsh/dircolors-solarized/dircolors.ansi-universal" "$HOME/.dir_colors"

    # links
    if [ -d "$HOME/dotfiles.local/links" ]; then
        ln -s "$HOME/dotfiles.local/links" "$HOME/links"
    fi
}

setup_osx
confirm_exe 'Setup dotfiles?' && create_dotfiles
confirm_exe 'Create symbolic links?' && create_dotfiles_symlinks
echo 'Setup completed!'

