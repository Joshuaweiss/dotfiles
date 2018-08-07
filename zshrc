TERM=xterm-256color

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Vi mode
bindkey -v
set editing-mode vi

# Path
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.cargo/bin"

if [[ -a "/usr/share/zsh/share/antigen.zsh" ]]; then
  source "/usr/share/zsh/share/antigen.zsh"
elif [[ -a "$(brew --prefix)/share/antigen/antigen.zsh" ]]; then
  source "$(brew --prefix)/share/antigen/antigen.zsh"
else
  echo "Cannot find Antigen install"
  exit 1
fi

# OH-MY-ZSH
antigen use oh-my-zsh

# NVM
export NVM_AUTO_USE=true
antigen bundle lukechilds/zsh-nvm

# Syntax Highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# Automatically change the directories after closing ranger
function rcd {
  if !which ranger; then
    echo "Cannot find ranger"
    exit 1
  fi
  tempfile="$(mktemp -t tmp.XXXXXX)"
  ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
}

alias vim=choose_vim
function choose_vim {
  if which nvim > /dev/null; then
    nvim $@
  elif which vim > /dev/null; then
    vim $@
  else
    vi $@
  fi
}

alias ls=choose_ls
function choose_ls {
  if which exa > /dev/null; then
    exa $@
  else
    ls $@
  fi
}

# Git aliases
alias gc="git commit"
alias gs="git status"
alias ga="git add"
alias gpff="git pff"
alias grb="git rb"

# Other
alias ppjson="python -m json.tool"

alias cpwd="pwd | pbcopy"
alias pcd='cd $(pbpaste)'

source "$HOME/.zsh_prompt"

tmux_status() {
    tmux refresh-client -S
}

if which tmux &> /dev/null && [ -n "$TMUX" ]; then
    add-zsh-hook precmd tmux_status
fi

if which tmux &> /dev/null && ! [ -n "$TMUX" ]; then
    if tmux list-sessions -F "#{session_name}" | grep '^S-'; then
        tmux new-session -t S \; new-window
    else
        tmux new-session -t S
    fi
fi


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/joshuaweiss/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/joshuaweiss/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/joshuaweiss/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/joshuaweiss/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh
