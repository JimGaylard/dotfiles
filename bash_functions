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
  eval $(gpg -d $1)
}
