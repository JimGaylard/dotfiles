source .bash_local
. /usr/local/share/chruby/chruby.sh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:~/bin:/Users/jimg/Library/Python/2.7/bin:$PATH
chruby ruby-1.9.3

set -o vi

export HISTCONTROL=ignoreboth
export EDITOR=/usr/local/bin/vim

alias ll='ls -AhCGF'
alias l='ls -alGF'
alias la='ls -AG'

alias tmux='tmux'
alias vim='/usr/local/bin/vim'
alias vi='/usr/local/bin/vim'

alias be='bundle exec'
alias gst='git status'

shopt -s histappend
#PROMPT_COMMAND='history -a; history -n'

# Delete an entry from ~/.ssh/known_hosts
# Usage: sshdel <line_number>
function sshdel { perl -i -n -e "print unless (\$. == $1)" ~/.ssh/known_hosts; }
