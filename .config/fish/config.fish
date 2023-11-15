# ~/.config/fish/config.fish
if status is-interactive
    # Commands to run in interactive sessions can go here
end


set fish_greeting
########## prompt ###########
function fish_prompt
    set -g fish_prompt_pwd_dir_length 3
    set wpath (prompt_pwd)
    echo "$wpath > "
end

########## Aliases ##########
alias ls='lsd -lah --icon never'
alias grep='grep --color=auto'
alias cat='bat'
alias vim='nvim'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias aura='sudo aura'
alias config='/usr/bin/git --git-dir=/$HOME/.cfg/ --work-tree=$HOME'

########## Exports ###########
export EDITOR=vim
#export PATH=$PATH:/some/path
export TERM=alacritty
export HISTCONTROL=erasedups
export HISTSIZE=500

######### Autostart ##########

