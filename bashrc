export PATH=/usr/local/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/bin:/sbin:~/bin:$PATH
export TZ=Australia/Melbourne

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.rea-slip-utils/bin

export REA_LDAP_USER=jgaylard

export AWS_REGION=ap-southeast-2
export AWS_DEFAULT_REGION=ap-southeast-2

# source other bash files
################################################
[ -e ~/.bash_functions ] && source ~/.bash_functions


if [ -e ~/.bash_prompt ]
then
  source ~/.bash_prompt
else
  TITLEBAR="\[\e]2;\w\a\]"
  GIT_PS1_SHOWDIRTYSTATE=1
  PROMPT="\u@\h:\w\$(__git_ps1 ' [%s]')\n\$ "
  PS1="$TITLEBAR\[\e[32;1m\]$PROMPT\[\e[0m\]"
fi

source $HOME/.git-prompt.sh

source /usr/local/share/chruby/chruby.sh
chruby 2

source ~/.aws-shortcuts/aws-shortcuts.sh
for file in $HOME/scripts/*
do
  source $file
done

# set environment and aliases
################################################
set -o vi

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
unset HISTFILESIZE
export EDITOR=$(which nvim)
shopt -s histappend

#if [ $TERM != "linux" ]; then
TITLEBAR="\[\e]2;\w\a\]"
#fi
GIT_PS1_SHOWDIRTYSTATE=1
PROMPT="\u@\h:\w\$(__git_ps1 ' [%s]')\n\$ "
PS1="$TITLEBAR\[\e[32;1m\]$PROMPT\[\e[0m\]"

[ -e ~/.bash_prompt ] && source ~/.bash_prompt
[ PROMPT_COMMAND ] && \
  export PROMPT_COMMAND="$PROMPT_COMMAND; history -a" || \
  PROMPT_COMMAND="history -a"

alias ll='ls -lG --color'
alias l='ls -laF --color'

alias ty='tmux loadb -'
alias sm='emacsclient -t'

alias be='bundle exec'
alias gst='git status -s'
alias gstt='git status'
alias gd='git diff'

alias vi=$(which vim)
alias gpg=gpg2
alias em='emacs -nw'
alias console='xdg-open $(aws-console-url)'
