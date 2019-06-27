#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install --yes emacs25 git zsh

chsh --shell `which zsh`

git config --global user.name "James Laverack"
git config --global user.email james@jameslaverack.com
