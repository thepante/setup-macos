fpath=($fpath "/Users/fabian/.zfunctions")
source /Users/fabian/.config/broot/launcher/bash/br

# Spaceship prompt
autoload -U promptinit; promptinit
prompt spaceship

HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=3000
HISTDUP=erase
ZSHZ_CASE=ignore

SPACESHIP_PROMPT_PREFIXES_SHOW=false
SPACESHIP_DIR_PREFIX=
SPACESHIP_DIR_COLOR="cyan"
SPACESHIP_VI_MODE_INSERT=''
SPACESHIP_VI_MODE_NORMAL=''
SPACESHIP_VI_MODE_COLOR="#626262" # antes 'black'
SPACESHIP_CHAR_SYMBOL="» " # ❯
SPACESHIP_CHAR_SYMBOL_SECONDARY="» "
SPACESHIP_CHAR_COLOR_SUCCESS="cyan"
SPACESHIP_CHAR_COLOR_SECONDARY="magenta"
SPACESHIP_EXEC_TIME_COLOR="#666666"

SPACESHIP_PHP_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_SVELTE_SHOW=false

SPACESHIP_PACKAGE_SHOW=true
SPACESHIP_PACKAGE_SUFFIX=" "
SPACESHIP_PACKAGE_COLOR="black"
SPACESHIP_PACKAGE_SYMBOL=

ZVM_VI_INSERT_ESCAPE_BINDKEY=kj

setopt NO_nomatch # avoid noglob issue

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

setopt histignoredups
setopt nosharehistory
setopt noextendedhistory
setopt histfindnodups

export PATH="$HOME/go/bin:$PATH"
export RIPGREP_CONFIG_PATH=~/.ripgreprc
export HOMEBREW_NO_AUTO_UPDATE=1
export VISUAL=nvim
export EDITOR=nvim
export LANG="UTF-8"
export LC_ALL=en_US.UTF-8
export DELTA_PAGER="less $LESS"

# ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=002
# ZSH_HIGHLIGHT_STYLES[precommand]=fg=002
# ZSH_HIGHLIGHT_STYLES[arg0]=bold

# FZF related
fzf_excluded="-E node_modules -E .git -E '*cache' -E '*go/pkg' -E 'Media' -E 'Movies' -E '.zsh_*' -E '.DS_Store' -E 'Library' -E 'vendor'"
export FZF_DEFAULT_OPTS='--ansi --multi'
export FZF_DEFAULT_COMMAND='fd -HLI -t f . '$fzf_excluded
export FZF_DIRS_COMMAND='fd -HLI -t d . '$fzf_excluded

# NVM - disabled
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv
PATH=$PATH:$(pyenv root)/shims

# Tmux plugins
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

source ~/.aliases
source ~/.aliases-priv

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.script-kill-apps.sh

tmux-git-autofetch() {
    ($TMUX_PLUGIN_MANAGER_PATH/tmux-git-autofetch/git-autofetch.tmux --current &)
}
add-zsh-hook chpwd tmux-git-autofetch

zoxide_to_ranger () {
    cd "$(eval zoxide query -i)" || exit
    # local precmd
    # for precmd in $precmd_functions; do
    #   $precmd
    # done
    zle reset-prompt
}
zle -N zoxide_to_ranger
bindkey '^f' zoxide_to_ranger

# TODO ARREGLAR ESTO!
# better command history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end # "^[OA" 
bindkey "^[[B" history-beginning-search-forward-end # "^[OB" 

eval "$(zoxide init zsh)"

source "$HOME/.sdkman/bin/sdkman-init.sh"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


tmux-git-autofetch() {(/Users/fabian/.tmux/plugins/tmux-git-autofetch/git-autofetch.tmux --current &)}
add-zsh-hook chpwd tmux-git-autofetch

