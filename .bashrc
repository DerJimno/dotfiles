# ~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


############ PSs ############
PS1="\W -> "
PS2=">"

########## Aliases ##########
alias ls='ls -lah --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias aura='sudo aura'
alias config='/usr/bin/git --git-dir=/$HOME/.cfg/ --work-tree=/$HOME'

########## Exports ###########
export EDITOR=nvim
#export PATH=$PATH:/some/path
export TERM=alacritty
export HISTCONTROL=erasedups
export HISTSIZE=500

######### Autostart ##########
pfetch
