# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoreboth
HISTTIMEFORMAT='%FT%T%z '
HISTIGNORE='ls*:exit*:history*:cd\ -:cd:cd\ \.\.'

export TZ="Asia/Tokyo"
stty stop undef
alias vi="vim"
alias ls="ls --color"
alias ghql='cd $(ghq list --full-path | peco)'
alias gitall="git log --oneline --decorate --graph --branches --tags --remotes"
. /root/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
PS1='\[[33m\]\D{%H:%M:%S}\[[m\] \[[36m\]\h:\W\[[m\] \[[1;32m\]$(__git_ps1 "< %s > ")\[[m\]$ '
