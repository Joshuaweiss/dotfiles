TERM=xterm-256color

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Vi mode
bindkey -v
set editing-mode vi

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Path
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.pyenv/shims"
export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.go/bin"
export PATH="$(brew --prefix python)/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
export GOPATH="$HOME/.go"
source $(brew --prefix nvm)/nvm.sh

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

if [[ -a "/usr/share/zsh/share/antigen.zsh" ]]; then
  source "/usr/share/zsh/share/antigen.zsh"
elif [[ -a "$(brew --prefix)/share/antigen/antigen.zsh" ]]; then
  source "$(brew --prefix)/share/antigen/antigen.zsh"
else
  echo "Cannot find Antigen install"
fi

export BAT_THEME="base16"

# OH-MY-ZSH
antigen use oh-my-zsh

# Syntax Highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# place this after nvm initialization!
# auto nvm use in directories with nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "$nvmrc_path")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Automatically change the directories after closing ranger
function rcd {
  if ! which ranger > /dev/null; then
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
    command vim $@
  else
    vi $@
  fi
}

alias ls=choose_ls
function choose_ls {
  if which exa > /dev/null; then
    exa $@
  else
    command ls $@
  fi
}

alias cat=choose_cat
function choose_cat {
  if which bat > /dev/null; then
    bat $@
  else
    command cat $@
  fi
}

# Git aliases
alias gc="git commit"
alias gs="git status"
alias ga="git add"

function git-my-diff() {
  git diff :1:$1 :2:$1
}

function git-their-diff() {
  git diff :1:$1 :3:$1
}

function git-merge() {
  vim -O <(git diff :1:$1 :2:$1) "$1" <(git diff :1:$1 :3:$1)
}

# Other
alias ppjson="python3 -m json.tool"
alias cpwd="pwd | pbcopy"
alias pcd='cd $(pbpaste)'

source "$HOME/.zsh_prompt"

tmux_status() {
  tmux refresh-client -S
}

if which tmux &> /dev/null; then
  if [ -z "$TMUX" ] && [ -n "$AUTO_TMUX" ] && [ ${UID} != 0 ]; then
    tmux new-session -A -s main
  else
    add-zsh-hook precmd tmux_status
  fi
fi
