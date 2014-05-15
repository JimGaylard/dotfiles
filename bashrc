export PATH=/usr/local/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/bin:/sbin:~/bin:$PATH

[ -e ~/.bash_local ] && source ~/.bash_local
[ -e ~/.bash_functions ] && source ~/.bash_functions

[ -e /usr/local/etc/bash_completion.d/git-prompt.sh ] &&  source /usr/local/etc/bash_completion.d/git-prompt.sh

set -o vi

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000
export EDITOR=/usr/local/bin/vim

#if [ $TERM != "linux" ]; then
TITLEBAR="\[\e]2;\w\a\]"
#fi
GIT_PS1_SHOWDIRTYSTATE=1
PROMPT="\u@\h:\w\$(__git_ps1 ' [%s]')\n\$ "
PS1="$TITLEBAR\[\e[32;1m\]$PROMPT\[\e[0m\]"

[ -e ~/.bash_prompt ] && source ~/.bash_prompt

alias ll='ls -lG'
alias l='ls -alGF'
alias la='ls -AG'

alias be='bundle exec'
alias gst='git status'
alias gd='git diff'
alias gco='git checkout'
alias gpp='git pull --rebase && git push'

alias sshjump='ssh -t -A deploy ssh'

alias vi=/usr/local/bin/vim
