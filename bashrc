source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

export PATH=/usr/local/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/bin:/sbin:~/bin:$PATH

source ~/.bash_local

set -o vi

export HISTCONTROL=ignoreboth
export EDITOR=/usr/local/bin/vim

alias ll='ls -l'
alias l='ls -alF'
alias la='ls -A'

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

function gst_all { for dir in $(ls -A); do [ -d $dir/.git ] && echo $dir && cd $dir && git status && cd ..; done }

function gpull_all { for dir in $(ls -A); do [ -d $dir/.git ] && echo $dir && cd $dir && git pull && cd ..; done }
