#!/bin/bash

set -eu pipefail


cd $HOME/dotfiles
git diff HEAD --exit-code

if [[ $(git log HEAD..origin/master --oneline) ]]; then
  echo 'remote changes to dotfiles'
  exit 1
fi
