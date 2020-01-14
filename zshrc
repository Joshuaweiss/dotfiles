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
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.pyenv/shims"
export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.cargo/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

if [[ -a "/usr/share/zsh/share/antigen.zsh" ]]; then
  source "/usr/share/zsh/share/antigen.zsh"
elif [[ -a "$(brew --prefix)/share/antigen/antigen.zsh" ]]; then
  source "$(brew --prefix)/share/antigen/antigen.zsh"
else
  echo "Cannot find Antigen install"
fi


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
alias ppjson="python -m json.tool"

alias cpwd="pwd | pbcopy"
alias pcd='cd $(pbpaste)'

source "$HOME/.zsh_prompt"

tmux_status() {
  tmux refresh-client -S
}

if which tmux &> /dev/null; then
    if [ -z "$TMUX" ] && [ ${UID} != 0 ]; then
      exec tmux new-session -A -s main
    else
      add-zsh-hook precmd tmux_status
    fi
fi

slugify() {
  echo "${1}" | iconv -t ascii//TRANSLIT | gsed -r 's/[^a-zA-Z0-9]+/-/g' | gsed -r 's/^-+\|-+$//g' | tr A-Z a-z
}

bb-tag () {
  local branch="$(slugify $(git branch | grep \* | cut -d ' ' -f2))"
  local commit="$(git log --pretty=format:'%h' -n 1)"
  local tag="${1}-${branch}-${commit}"
  git tag $tag
  echo $tag
}

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/joshuaweiss/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/joshuaweiss/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/joshuaweiss/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/joshuaweiss/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/joshuaweiss/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/joshuaweiss/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh
