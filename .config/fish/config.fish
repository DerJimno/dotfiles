# ~/.config/fish/config.fish
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# removes welcome message
set fish_greeting

########## prompt ###########
function fish_prompt
    set -g fish_prompt_pwd_dir_length 3
    set wpath (prompt_pwd)
    echo "$wpath > "
end

########## Aliases ##########
alias ls='lsd -lah --icon never --group-directories-first'
alias grep='grep --color=auto'
alias cat='bat'
alias vim='nvim'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias config='/usr/bin/git --git-dir=/$HOME/.cfg/ --work-tree=$HOME'
alias config-skip='config update-index --skip-worktree'
alias config-unskip='config update-index --no-skip-worktree'
alias config-skipped='config ls-files -v | grep "^S"'

########## Exports ###########
set -gx EDITOR nvim
set -gx TERM alacritty
set -x MANPAGER "nvim +Man!"
set -U fish_user_paths $HOME/.local/share/fnm

######### Autostart ##########
