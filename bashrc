export PATH=/usr/local/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/bin:/sbin:~/bin:$PATH

source ~/.bash_local

source /usr/local/etc/bash_completion.d/git-prompt.sh

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

shopt -s histappend

# Delete an entry from ~/.ssh/known_hosts
# Usage: sshdel <line_number>
function sshdel { perl -i -n -e "print unless (\$. == $1)" ~/.ssh/known_hosts; }

function gst_all {
  for dir in $(ls -A)
  do
    [ -d $dir/.git ] && echo "<-----------$dir------------>" && cd $dir && git status && cd ..
  done
}

function gpull_all { for dir in $(ls -A); do [ -d $dir/.git ] && echo $dir && cd $dir && git pull && cd ..; done }

function success {
  rc=$?
  if [ $rc == 0 ]
  then
    if hash say
      then
        say success
    fi
    echo success
    return 0
  else
    if hash say
    then
      say failed
    fi
    echo failed
    return 1
  fi
}
