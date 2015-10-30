#!/bin/sh
set -e
############################
# .makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# !!!!!!!!!!!!!! May need to chmod +x makesymlinks.sh in order to run this file !!!!!!!!!!
############################

########## Variables

dir="$HOME/dotfiles"                         # dotfiles directory
olddir="$HOME/dotfiles_old$(date +'%y%m%d%H%M')" # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bashrc bash_profile bash_functions bash_prompt gitignore_global pryrc \
       tmux.conf vimrc vimrc.bundles"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir $olddir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old
# directory, then create symlinks from the homedir to any
# files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    [ -e ~/.$file ] && mv -v ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -sv $dir/$file ~/.$file
done

mkdir -p ~/.config/nvim
ln -s vimrc ~/.config/nvim/init.vim
ln -s vimrc.bundles ~/.config/nvim/init.vim
