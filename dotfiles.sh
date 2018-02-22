#!/bin/bash

set -eu pipefail


cd $HOME/dotfiles
git diff HEAD --exit-code
