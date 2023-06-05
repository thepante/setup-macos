fpath=($fpath "/Users/fabian/.zfunctions")
source /Users/fabian/.config/broot/launcher/bash/br

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

SPACESHIP_PROMPT_PREFIXES_SHOW=false
SPACESHIP_DIR_PREFIX=
SPACESHIP_DIR_COLOR="cyan"
SPACESHIP_VI_MODE_INSERT="I"
SPACESHIP_VI_MODE_NORMAL="N"
SPACESHIP_VI_MODE_COLOR="black"
#SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_CHAR_SYMBOL="> "
SPACESHIP_CHAR_SYMBOL_SECONDARY="❯ "
SPACESHIP_CHAR_COLOR_SUCCESS="cyan"
SPACESHIP_CHAR_COLOR_SECONDARY="magenta"
SPACESHIP_EXEC_TIME_COLOR="black"

SPACESHIP_PHP_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_SVELTE_SHOW=false

SPACESHIP_PACKAGE_SHOW=true
SPACESHIP_PACKAGE_SUFFIX=" "
SPACESHIP_PACKAGE_COLOR="black"
SPACESHIP_PACKAGE_SYMBOL=

HISTFILE=~/.zsh_history
HISTSIZE=1800
SAVEHIST=1800
HISTDUP=erase

# this was because that noglob issue
setopt NO_nomatch

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

setopt histignoredups
setopt nosharehistory
setopt noextendedhistory
setopt histfindnodups

setopt HIST_FIND_NO_DUPS

source ~/.aliases
source ~/.aliases-priv

export RIPGREP_CONFIG_PATH=~/.ripgreprc

# ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=002
# ZSH_HIGHLIGHT_STYLES[precommand]=fg=002
# ZSH_HIGHLIGHT_STYLES[arg0]=bold

ZSHZ_CASE=ignore

export VISUAL=nvim
export EDITOR=nvim

#ZVM_VI_ESCAPE_BINDKEY=kj
ZVM_VI_INSERT_ESCAPE_BINDKEY=kj

source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
#source ~/.zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FZF related
fzf_excluded="-E node_modules -E .git -E '*cache' -E '*go/pkg' -E 'Media' -E 'Movies' -E '.zsh_*' -E '.DS_Store' -E 'Library' -E 'vendor'"
export FZF_DEFAULT_OPTS='--ansi --multi'
export FZF_DEFAULT_COMMAND='fd -HLI -t f . '$fzf_excluded
export FZF_DIRS_COMMAND='fd -HLI -t d . '$fzf_excluded


export HOMEBREW_NO_AUTO_UPDATE=1
export LANG="UTF-8"

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

clear
# chpwd() ls

# Kill apps that match string
function kill-apps() {
  IFS=$'\n'
  red=$(tput setaf 1)
  normal=$(tput sgr0)
  if [ -z "$1" ] || [ "$1" = "--help" ]; then
    printf "%s\n" "Usage: kill-apps string"
    return 0
  fi
  printf "%s\n" "Finding apps that match “$1”…"
  sleep 1
  processes=($(pgrep -afil "$1"))
  if [ ${#processes[@]} -eq 0 ]; then
    printf "%s\n" "No apps found"
    return 0
  else
    printf "%s\n" "${processes[@]}"
    printf "$red%s$normal" "Kill found apps (y or n)? "
    read -r answer
    if [ "$answer" = "y" ]; then
      printf "%s\n" "Killing found apps…"
      sleep 1
      for process in "${processes[@]}"; do
        echo $process | awk '{print $1}' | xargs sudo kill 2>&1 | grep -v "No such process"
      done
      printf "%s\n" "Done"
      return 0
    fi
  fi
}


eval "$(zoxide init zsh)"

# ~/.tmux/plugins
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# ~/.config/tmux/plugins
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

# better command history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
#bindkey "^[OA" history-beginning-search-backward-end
#bindkey "^[OB" history-beginning-search-forward-end

# delete line on cmd+backspace 
#bindkey '^H' backward-kill-line

