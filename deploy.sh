#!/usr/bin/env bash

#TODO:
# option to dry run


# targets for deploy all keyword (the current programs I use regularly)
all_targets=("kitty" "zsh" "starship" "nvim" "ranger" "tmux" "colors" "zathura" "stylua" "latexindent")

dotfiles=$(pwd) # TODO: this should always be the location of this script

targets=( `printf "%q\n" "$@" | sort -u` ) # remove duplicate values
synced=()
failed=()
# echo $@
# echo ${synced[@]}

sync() {
    echo -e "\nAttempting to sync $1"
case $1 in
    #copy zsh directory and keep .zshrc in $HOME
    zsh) 
        mkdir -p  $HOME/.config/zsh &&
        rsync -rav $dotfiles/config/zsh $HOME/.config &&
        ln -snT ~/.config/zsh/.zshrc ~/.zshrc &&
        synced+=("Zsh");;

    starship | prompt) 
        ##Starship Prompt
        rsync -rav $dotfiles/config/starship.toml $HOME/.config &&
        synced+=("Starship");;

    alacritty)
        mkdir -p $HOME/.config/alacritty &&
        rsync -rav $dotfiles/config/alacritty $HOME/.config &&
        synced+=("Alacritty");;

    foot)
        mkdir -p $HOME/.config/foot &&
        rsync -rav $dotfiles/config/foot $HOME/.config &&
        synced+=("Foot");;

    kitty)
        mkdir -p $HOME/.config/kitty &&
        rsync -rav $dotfiles/config/kitty $HOME/.config &&
        synced+=("Kitty");;

    # dircolors / lscolors
    colors | dircolors)
        rsync -rav $dotfiles/.dircolors $HOME &&
        synced+=("Dircolors");;

    ranger)
        mkdir -p $HOME/.config/ranger/plugins &&
        rsync -rav $dotfiles/config/ranger $HOME/.config &&
        synced+=("Ranger");;

    nvim | neovim)
        mkdir -p $HOME/.config/nvim &&
        rsync -rav $dotfiles/config/nvim $HOME/.config &&
        synced+=("Neovim");;

    tmux)
        mkdir -p $HOME/.config/tmux &&
        rsync -rav $dotfiles/config/tmux $HOME/.config &&
        # ln -snT ~/.config/tmux/.tmux.conf ~/.tmux.conf &&
        synced+=("Tmux");;

    #pdf viewer
    zathura)
        mkdir -p $HOME/.config/zathura &&
        rsync -rav $dotfiles/config/zathura $HOME/.config  &&
        synced+=("Zathura");;

    stylua)
        rsync -rav $dotfiles/.stylua.toml $HOME/ &&
        synced+=("Stylua");;

    latexindent)
        rsync -rav $dotfiles/indentconfig.yaml $HOME/ &&
        synced+=("LatexIndent");;

    test) # fails
        return 1 &&
            echo "synced test";;

    ##Nvim - latex formatter
    # rsync -rav $dotfiles/config/tex-fmt $HOME/.config
    # echo "Synced tex-fmt"

    *)
        echo "$1 is not an option";;
esac
}


# if all is present in inputs, set all as the input
[[ " ${targets[*]} " == *' all '* ]] && targets=${all_targets[@]} && echo "deploying all";

# deploy all targets
for key in ${targets[@]}; do
    sync ${key}
    if [[ $? = 1 ]]; then
        failed+=($key)
        echo "failed"
    fi
done

echo ""

# summary output on results
for task in ${synced[@]}; do
    echo "Synced ${task}"
done

echo ""

if [[ -n $"{failed[@]}" ]]; then
    for task in ${failed[@]}; do
        echo "Failed to sync ${task}"
    done
    exit 1
fi
