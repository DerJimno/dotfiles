# ~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


############ PSs ############
PS1="\w -> "
PS2=">"

########## Aliases ##########
alias ls='lsd -lah --icon never'
alias grep='grep --color=auto'
alias cat='bat'
alias vim='nvim'
alias ..='cd ..'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias aura='sudo aura'
alias config='/usr/bin/git --git-dir=/$HOME/.cfg/ --work-tree=/$HOME'

########## Exports ###########
export EDITOR=vim
#export PATH=$PATH:/some/path
export TERM=alacritty
export HISTCONTROL=erasedups
export HISTSIZE=500

######### Autostart ##########
pfetch

############ binds ###########
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
