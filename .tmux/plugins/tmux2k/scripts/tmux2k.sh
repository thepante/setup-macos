#!/usr/bin/env bash

export LC_ALL=en_US.UTF-8
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$current_dir"/utils.sh

refresh_rate=$(get_tmux_option "@tmux2k-refresh-rate" 60)
IFS=' ' read -r -a lplugins <<<"$(get_tmux_option '@tmux2k-left-plugins' '')"
IFS=' ' read -r -a rplugins <<<"$(get_tmux_option '@tmux2k-right-plugins' 'git')"

# text=$(get_tmux_option "@tmux2k-text" '#282a36')
# bg_main=$(get_tmux_option "@tmux2k-bg-main" '#000000')
# bg_alt=$(get_tmux_option "@tmux2k-bg-alt" '#1f1f1f')
# black=$(get_tmux_option "@tmux2k-black" '#0a0a0f')
# white=$(get_tmux_option "@tmux2k-white" '#FFFFFF')
# gray=$(get_tmux_option "@tmux2k-white" '#666787')
# red=$(get_tmux_option "@tmux2k-red" '#ff001f')
# light_red=$(get_tmux_option "@tmux2k-light-red" '#ff0055')
# green=$(get_tmux_option "@tmux2k-green" '#3dd50a')
# light_green=$(get_tmux_option "@tmux2k-light-green" '#ccffcc')
# blue=$(get_tmux_option "@tmux2k-blue" '#5FF1FF')
# light_blue=$(get_tmux_option "@tmux2k-light-blue" '#5FF1FF')
# yellow=$(get_tmux_option "@tmux2k-yellow" '#ffb86c')
# light_yellow=$(get_tmux_option "@tmux2k-light-yellow" '#ffd21a')
# purple=$(get_tmux_option "@tmux2k-purple" '#bf58ff')
# light_purple=$(get_tmux_option "@tmux2k-light-purple" '#ff65c6')

duo_bg=$(get_tmux_option "@tmux2k-duo-bg" 'default')
duo_fg=$(get_tmux_option "@tmux2k-duo-fg" 'gray')
text=$(get_tmux_option "@tmux2k-white" "#282a36")
bg_main=$(get_tmux_option "@tmux2k-bg-main" "$duo_bg")
bg_alt=$(get_tmux_option "@tmux2k-bg-alt" "$duo_bg")
black=$(get_tmux_option "@tmux2k-black" "$duo_bg")
white=$(get_tmux_option "@tmux2k-white" "$duo_fg")
gray=$(get_tmux_option "@tmux2k-white" '#666787')
red=$(get_tmux_option "@tmux2k-red" "#ff001f")
light_red=$(get_tmux_option "@tmux2k-light-red" "#ff001f")
green=$(get_tmux_option "@tmux2k-green" "#ccffcc")
light_green=$(get_tmux_option "@tmux2k-light-green" "#ccffcc")
blue=$(get_tmux_option "@tmux2k-blue" "#5FF1FF")
light_blue=$(get_tmux_option "@tmux2k-light-blue" "#5FF1FF")
yellow=$(get_tmux_option "@tmux2k-yellow" "$duo_fg")
light_yellow=$(get_tmux_option "@tmux2k-light-yellow" "$duo_fg")
purple=$(get_tmux_option "@tmux2k-purple" "$duo_fg")
light_purple=$(get_tmux_option "@tmux2k-light-purple" "$duo_fg")

declare -A plugin_colors=(
    ["git"]="green text"
    ["cpu"]="blue text"
    ["ram"]="light_yellow text"
    ["gpu"]="yellow text"
)

get_plugin_colors() {
    local plugin_name="$1"
    local default_colors="${plugin_colors[$plugin_name]}"
    get_tmux_option "@tmux2k-${plugin_name}-colors" "$default_colors"
}

get_plugin_bg() {
    IFS=' ' read -r -a colors <<<"$(get_plugin_colors "$1")"
    return "${colors[0]}"
}

set_theme() {
    text=$bg_main
    plugin_colors=(
        ["git"]="text gray"
        ["cpu"]="text gray"
        ["ram"]="text light_yellow"
    )
}

set_options() {
    tmux set-option -g status-interval "$refresh_rate"
    tmux set-option -g status-left-length 100
    tmux set-option -g status-right-length 100
    tmux set-option -g status-left ""
    tmux set-option -g status-right ""

    tmux set-option -g pane-active-border-style "fg=${gray}"
    tmux set-option -g pane-border-style "fg=${gray}"
    tmux set-option -g message-style "bg=${bg_main},fg=${blue}"
    tmux set-option -g status-style "bg=${bg_main},fg=${white}"
    tmux set -g status-justify left
}

start_icon() {
    #tmux set-option -g status-left "#[bg=default,fg=${blue}] "󰋙" #S  "
    tmux set-option -g status-left "#[bg=default,fg=${blue}] "󰋙" #{b:pane_current_path} "
    # tmux set-option -g status-left "#[bg=default,fg=${blue}] "󰋙" #{b:pane_current_path} #(gitmux -cfg ~/.gitmux.conf '#{pane_current_path}')"
    # #(gitmux -cfg ~/.gitmux.conf '#{pane_current_path}')
}

main() {
    set_theme
    set_options
    start_icon
    tmux set-option -g status-right "#[fg=$gray,bg=${!colors[0]}] #(gitmux -cfg ~/.gitmux.conf '#{pane_current_path}') "
}

main
