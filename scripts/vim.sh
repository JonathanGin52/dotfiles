#!/bin/bash

brew info vim | grep --quiet 'Not installed' && brew install vim

vim +PlugInstall +PlugClean! +qa

