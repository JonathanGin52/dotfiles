#!/usr/bin/env sh
curl -s https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info > /tmp/alacritty.info
sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info
