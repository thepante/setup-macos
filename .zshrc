fpath=($fpath "/Users/fabian/.zfunctions")
# source /Users/fabian/.config/broot/launcher/bash/br

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.zsh/theme.omp.json)"
fi

autoload -U select-word-style
select-word-style bash

HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=3000
HISTDUP=erase
ZSHZ_CASE=ignore

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


export PATH="$HOME/.bun/bin:$PATH"
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

# # NVM - disabled
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# # pyenv
# PATH=$PATH:$(pyenv root)/shims

# android sdk
# Create a JAVA_HOME variable, determined dynamically
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-1.8.jdk/Contents/Home

# # export JAVA_HOME=$(/usr/libexec/java_home -v 11)
# # export JAVA_HOME=$(/usr/libexec/java_home -v 17)
# export PATH=$JAVA_HOME/bin:$PATH

# export ANDROID_HOME=~/Library/Android/sdk/
# export ANDROID_SDK=~/Library/Android/sdk/
# export ANDROID_SDK_ROOT=~/Library/Android/sdk/

# # export GRADLE_HOME=/Library/gradle/gradle-3.2
# # export PATH=$PATH:$GRADLE_HOME/bin

# export GRADLE_HOME=/Users/fabian/.sdkman/candidates/gradle/current
# export PATH=$PATH:$GRADLE_HOME/bin

# # PATH=$PATH:/opt/homebrew/opt/gradle@7/bin/

PATH=$PATH:"$ANDROID_HOME"platform-tools
PATH=$PATH:"$ANDROID_HOME"tools
# export ANDROID_HOME=/Users/$USER/Library/Android/sdk
# export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# export JAVA_HOME="$(/usr/libexec/java_home)"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-1.8.jdk/Contents/Home
# export PATH=${JAVA_HOME}/bin:$PATH

# Tmux plugins
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

source ~/.aliases
source ~/.aliases-priv

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.script-kill-apps.sh

# # TODO ARREGLAR ESTO!
# # better command history
# autoload -U history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey "^[[A" history-beginning-search-backward-end # "^[OA"
# bindkey "^[[B" history-beginning-search-forward-end # "^[OB"
# # bindkey "^[DA" history-beginning-search-backward-end # "^[OA"
# # bindkey "^[DB" history-beginning-search-forward-end # "^[OB"

# eval "$(fzf --zsh)"

# # # source "$HOME/.zsh/kk/kk.plugin.zsh"
# source "$HOME/.sdkman/bin/sdkman-init.sh"

#THI MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# [ -n "$SSH_AUTH_SOCK" ] && (echo "$SSH_AUTH_SOCK" > ~/.ssh/ssh-agent.env_sock)
# [ -n "$SSH_AGENT_PID" ] && (ps aux | grep ssh-agent | awk '{print $2}' > ~/.ssh/ssh-agent.env_pid)
# eval $(ssh-agent)
# echo "sourced ok .zshrc" >> /tmp/git-autofetch.log

tmux-window-name() {($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)}
add-zsh-hook chpwd tmux-window-name

tmux-git-autofetch() {(/Users/fabian/.tmux/plugins/tmux-git-autofetch/git-autofetch.tmux --current &)}
add-zsh-hook chpwd tmux-git-autofetch

tmux-refresh-status-bar() {(tmux refresh-client -S &)}
add-zsh-hook chpwd tmux-refresh-status-bar

eval "$(zoxide init --cmd a zsh)"
eval "$(direnv hook zsh)"
eval "$(atuin init zsh)"

