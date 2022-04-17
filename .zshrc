fpath=($fpath "/Users/fabian/.zfunctions")

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

SPACESHIP_PROMPT_PREFIES_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_DIR_PREFIX=
SPACESHIP_VI_MODE_INSERT="I"
SPACESHIP_VI_MODE_NORMAL="N"
SPACESHIP_VI_MODE_COLOR="red"
SPACESHIP_CHAR_SYMBOL=" "
SPACESHIP_CHAR_SYMBOL_SECONDARY=" "
SPACESHIP_CHAR_COLOR_SUCCESS="cyan"
SPACESHIP_CHAR_COLOR_SECONDARY="magenta"

HISTFILE=~/.zsh_history
HISTSIZE=800
SAVEHIST=800
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
fzf_excluded="-E node_modules -E .git -E '*cache' -E '*go/pkg' -E 'Media' -E 'Movies' -E '.zsh_*' -E '.DS_Store'"
export FZF_DEFAULT_OPTS='--ansi --multi'
export FZF_DEFAULT_COMMAND='fd -HLI -t f . '$fzf_excluded
export FZF_DIRS_COMMAND='fd -HLI -t d . '$fzf_excluded

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export HOMEBREW_NO_AUTO_UPDATE=1
export LANG="UTF-8"

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

clear
# chpwd() ls

