#!/usr/bin/env bash
# ~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

############ PSs ############
PS1="\w -> "
PS2=">"

########## Aliases ##########
alias ls='lsd -lah --icon never --group-directories-first'
alias grep='grep --color=auto'
alias cat='bat'
alias vim='nvim'
alias ..='cd ..'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias config='/usr/bin/git --git-dir=/$HOME/.cfg/ --work-tree=/$HOME'

########## Exports ###########
export EDITOR=nvim
export TERM=alacritty
export HISTCONTROL=erasedups
export HISTSIZE=500
export MANPAGER="nvim +Man!"

######### Autostart ##########
pfetch

############ binds ###########
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# fnm
FNM_PATH="/home/jimno/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# fnm
FNM_PATH="/home/jimno/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
