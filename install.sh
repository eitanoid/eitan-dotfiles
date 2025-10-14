#!/usr/bin/env bash

read -p "Download Tmux TPM? (y/n)?" CONT
if [ "$CONT" = "y" ]; then
    git clone https://github.com/tmux-plugins/tpm $(pwd)/config/tmux/plugins/tpm
else
	echo "skipping";
fi

# git curl nvim ranger tmux git-delta 
