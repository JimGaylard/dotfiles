#!/bin/bash

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

function aws_credentials {
  if [ -e $1 ]
  then
    file=$1
  else
    file="$HOME/.aws/$1"
  fi
  eval $(gpg -d $file)
}

# bash_completion for aws_credentials
_aws_creds() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W  "$(ls ~/.aws)"  -- $cur) )
}
complete -F _aws_creds aws_credentials

clean_docker_images() {
  docker images --no-trunc | grep none | awk '{print $3}' | xargs docker rmi -f
}

clean_docker_containers() {
  docker ps -aq | xargs docker rm
}

delete_docker_image() {
  docker images --no-trunc | grep $1 | awk '{print $3}' | xargs docker rmi -f
}

docker_killall() {
  docker kill $( docker ps -q )
}

docker_ip() {
  docker inspect --format='{{ .NetworkSettings.IPAddress }}' $1
}

docker_latest() {
  docker images | grep latest | sort
}

tmnew() {
  tmux new-session -s $1
}
