#!/usr/bin/env bash
languages=`echo "bash rust go python php nodejs typescript javascript html css" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk" | tr ' ' '\n'`
selected=`printf "$languages\n$core_utils" | fzf`

read -p "Search: " query
query=`echo $query | tr ' ' '+'`

if printf "$languages" | grep -qs $selected; then
    curl -s cht.sh/$selected/$query | bat --style=numbers
else
    curl -s cht.sh/$selected~$query | bat --style=numbers
fi

