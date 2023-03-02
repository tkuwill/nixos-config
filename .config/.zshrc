# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b %m%u%c'

setopt promptsubst

PROMPT='%F{14} %~ ${vcs_info_msg_0_} %f
%F{40} %#%f  '


bindkey "\e[3~" delete-char
# for urxvt and uxterm
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
# for tmux
bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line
# for st terminal
bindkey "^[[H" beginning-of-line
bindkey "^[[4~" end-of-line 

# Use C-x C-e to open the default editor to edit the command line
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

zstyle ':completion:*' menu yes select
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=99999
SAVEHIST=99999
HISTORY_IGNORE="(rm -rf|rm -rf .git|neofetch|vifm|musicDownloadTui|newsboat|free|uname -r|uname -a|free -h|df|df -h|htop|vim .vimrc|nmtui|tmux kill-session -t 1|cd ..|vim .zshrc|vim .zsh_history|bat .zsh_history|source ~/.zshrc|ls|cd|pwd|exit|cmus|la|bye|ping|mpv|yt-dlp|tmux|acpi|lazygit|live-server| ..)"
unsetopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/will/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
alias la="ls -la --color=auto"
alias ls='ls --color=tty'
alias musicDownloadTui="/home/will/shellscripts/musicDownloadTui.sh"

TIMEFMT=$'real\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# npm package
export PATH=~/.npm-packages/bin:$PATH
export NODE_PATH=~/.npm-packages/lib/node_modules

# For colorful man 
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# St title

# THSTATUS=`tput tsl`
# FHSTATUS=`tput fsl`

# set_xterm_title() {
#      if tput hs ; then
#          print -Pn "$THSTATUS$@$FHSTATUS"
#      fi
# }
# preexec() {
#     set_xterm_title "%n@%m: %50>...>$1%<<"
# }
# precmd() {
#     set_xterm_title "%n@%m: %50<...<%~%<<"
# }
