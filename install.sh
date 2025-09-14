#!/bin/bash

# Updates/Installs nvim

rm -rf $HOME/.local/share/nvim
rm -rf $HOME/.config/nvim
ln -Fs $PWD $HOME/.config/nvim
