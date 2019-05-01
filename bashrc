export PATH=/usr/local/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/bin:/sbin:~/bin:~/.npm-global/bin:$PATH
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
# shellcheck source=/home/jgaylard/.bash_functions
[ -e ~/.bash_functions ] && source ~/.bash_functions

for f in ~/.bash-my-aws/lib/*-functions
do
  # shellcheck source=/dev/null
  source "$f"
done


if [ -e ~/.bash_prompt ]
then
  # shellcheck source=/home/jgaylard/.bash_prompt
  source ~/.bash_prompt
else
  TITLEBAR="\[\e]2;\w\a\]"
  GIT_PS1_SHOWDIRTYSTATE=1
  PROMPT="\u@\h:\w\$(__git_ps1 ' [%s]')\n\$ "
  PS1="$TITLEBAR\[\e[32;1m\]$PROMPT\[\e[0m\]"
fi

# shellcheck source=/home/jgaylard/.git-prompt.sh
source "$HOME/.git-prompt.sh"

source /usr/local/share/chruby/chruby.sh
chruby 2

# shellcheck source=/home/jgaylard/.aws-shortcuts/aws-shortcuts.sh
source ~/.aws-shortcuts/aws-shortcuts.sh
for file in "$HOME"/scripts/*
do
  # shellcheck source=/dev/null
  source "$file"
done

# set environment and aliases
################################################
set -o vi

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
unset HISTFILESIZE
EDITOR=$(command -v nvim)
export EDITOR
shopt -s histappend

#if [ $TERM != "linux" ]; then
TITLEBAR="\[\e]2;\w\a\]"
#fi
GIT_PS1_SHOWDIRTYSTATE=1
PROMPT="\u@\h:\w\$(__git_ps1 ' [%s]')\n\$ "
PS1="$TITLEBAR\[\e[32;1m\]$PROMPT\[\e[0m\]"

# shellcheck source=/home/jgaylard/.bash_prompt
[ -e ~/.bash_prompt ] && source ~/.bash_prompt
[ "$PROMPT_COMMAND" ] && \
  export PROMPT_COMMAND="$PROMPT_COMMAND; history -a" || \
  PROMPT_COMMAND="history -a"

alias ty='tmux loadb -'

alias gst='git status -s'
alias gstt='git status'
alias gd='git diff'

alias gpg=gpg2
alias console='xdg-open $(aws-console-url)'
