#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## Command History configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt nonomatch
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
# historical backward/forward search with linehead string
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# auto chnage directory
setopt auto_cd
# ls after cd
function chpwd() { ls -GF }
# cd search path
cdpath=(~ ..)
# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd
# command correct edition before each completion attempt
setopt correct
# no remove postfix slash of command line
setopt noautoremoveslash
# no beep sound when complete list displayed
setopt nolistbeep

disable r

# zaw.zsh 
#
# from http://yagays.github.io/blog/2013/05/20/zaw-zsh/
# autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
# add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# source ~/zaw/zaw.zsh
zstyle ':filter-select' case-sensitive yes
# bindkey '^@' zaw-cdr

[ -f ~/.zshrc.func ] && source ~/.zshrc.func

if [ -n "$(get_os)" ]; then
  f="$HOME/.zshrc.$(get_os)"
  if [ -f "$f" ]; then
    source "$f"
  fi
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

## fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--border'
export FZF_TMUX_HEIGHT="50%"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --glob '!.git/*'"
export FZF_CTRL_T_OPTS="--preview 'bat  --color=always --style=header,grid --line-range :100 {}'"
export FZF_ALT_C_COMMAND="fd -t d . | sort"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

## bat
export BAT_THEME="Gray Matter Dark"

[ -f ~/.zshrc.aliases ] && source ~/.zshrc.aliases
## Command aliases

#setopt complete_aliases
# alias g="git"
# alias gi="git"
# alias gs="git status -s -b"
# alias gst="git status -s -b"
# alias gc="git commit"
# alias gca="git commit -a"
# alias gcls="git config --list | grep alias"


#alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`' 

# if [ -f /usr/local/bin/rbenv ]; then
#   eval "$(rbenv init --no-rehash -)"
# fi

export EDITOR='vim'
export VISUAL='vim'
#[[ -s /Users/hara/.tmuxinator/scripts/tmuxinator ]] && source /Users/hara/.tmuxinator/scripts/tmuxinator
#
export GOPATH="$HOME"
export PATH="$PATH:$GOPATH/bin"

export RUST_BACKTRACE=1

for i in $HOME/etc/profile.d/*.sh ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then
            source "$i"
        else
            source "$i" >/dev/null 2>&1
        fi
    fi
done

[ -f ~/.zshrc.tools ] && source ~/.zshrc.tools

[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

export PATH="$HOME/.cargo/bin:$PATH"

export TERM=xterm-256color
