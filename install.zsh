#!/bin/zsh

function safe_move {
    local SOURCE=$1
    local DESTINATION=$2

    if [[ -f $DESTINATION ]]; then
        safe_move $DESTINATION "${DESTINATION}.old"
    fi

    mv $SOURCE $DESTINATION
}

function safe_link {
    local SOURCE=$1
    local DESTINATION=$2

    if [[ -L $DESTINATION ]]; then
        rm $DESTINATION
    fi

    if [[ -f $DESTINATION ]]; then
        safe_move $DESTINATION "${DESTINATION}.old"
    fi

    ln -s $SOURCE $DESTINATION
}

local DIR="$(pwd)"
if ! cat "${DIR}/install.zsh" | grep "CURRENT FILE CHECK" > /dev/null; then
    echo "This script must be run from the dotfiles directory"
    exit 1
fi

safe_link $DIR/tmux.conf ~/.tmux.conf
safe_link $DIR/tmux_theme ~/.tmux_theme
safe_link $DIR/zshrc ~/.zshrc
safe_link $DIR/zsh_prompt ~/.zsh_prompt
safe_link $DIR/vimrc ~/.vimrc
safe_link $DIR/vimrc ~/.config/nvim/init.vim
safe_link $DIR/alacritty ~/.config/alacritty/alacritty.yml
safe_link $DIR/gitconfig ~/.gitconfig
safe_link $DIR/chunkwmrc ~/.chunkwmrc
safe_link $DIR/khdrc ~/.khdrc
