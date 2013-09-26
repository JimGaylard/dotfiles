source ~/.bash_local
. /usr/local/share/chruby/chruby.sh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:~/bin:/Users/jimg/Library/Python/2.7/bin:$PATH
chruby ruby-1.9.3

set -o vi

export HISTCONTROL=ignoreboth
export EDITOR=/usr/local/bin/vim

alias ll='ls -AhCGF'
alias l='ls -alGF'
alias la='ls -AG'

alias be='bundle exec'
alias gst='git status'

alias vi=/usr/local/bin/vim

shopt -s histappend

# gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info"
# if [ -f "${HOME}/.gpg-agent-info" ]; then
#     . "${HOME}/.gpg-agent-info"
#     export GPG_AGENT_INFO
#     export SSH_AUTH_SOCK
# fi

# GPG_TTY=$(tty)
# export GPG_TTY


# Delete an entry from ~/.ssh/known_hosts
# Usage: sshdel <line_number>
function sshdel { perl -i -n -e "print unless (\$. == $1)" ~/.ssh/known_hosts; }
