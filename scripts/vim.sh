#!/bin/bash

brew info nvim | grep --quiet 'Not installed' && brew install nvim

nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"
