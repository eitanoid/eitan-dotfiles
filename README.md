# .dotfiles!

A collection of programs I use and my configuration for them.

Try out my Neovim config in Docker!
```sh
docker run -w /tmp -it --rm alpine:edge sh -uelic 'addgroup -S eitan && adduser -S eitan -G eitan --shell /bin/sh && apk add alpine-sdk yarn python3 ripgrep git neovim=0.11.1-r1 bash curl --update && su -c "git clone https://github.com/eitanoid/eitan-dotfiles.git && mkdir -p /home/eitan/.config && cp -R eitan-dotfiles/config/nvim /home/eitan/.config/nvim" eitan && su -c "nvim --headless +\"Lazy! sync\" +qa && nvim" eitan'  
```

## Programs

<details>
<summary>List of programs I like to install</summary>

- [direnv](https://direnv.net/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fzf](https://github.com/junegunn/fzf)

</details>

<details>
<summary>Zsh</summary>

Zsh with `vi` mode enabled using the [zinit](https://github.com/zdharma-continuum/zinit) package manager and [starship](starship.rc) for prompt.

[zsh-Autocomplete](https://github.com/marlonrichert/zsh-autocomplete.git)
[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
[zsh-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
[reverse-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
[zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode.git)


| Action                  | Mode   | Bind                 |
| :---------------------- | :----- | :------------------- |
| Enter Normal Mode       | Insert | `Esc`                |
| Enter Insert Mode       | Normal | `i`,`a`,`o`          |
| Search Histroy Prefixed | Insert | `CTRL+Q`, `CTRL+P`   |
| Search Histtory Prefiex | Normal | `SHIFT+J`, `SHIFT+K` |
| Edit in Text Editor     | Visual | `vvv`                |


</details>


<details>

<summary>Tmux</summary>

 | Action                    | Mode   | Bind                 |
 | :----------------------   | :----- | :------------------- |
 | Prefix                    | any    | `CTRL-A`             |
 | split-window (vertical)   | prefix | `-`                  |
 | split-window (horizontal) | prefix | `|`                  |
 | Copy mode                 | prefix | `[`                  |
 | Swap window left/right    | prefix | `<`, `>`             |
 | Visual Block              | Copy   | `CTRL-V`             |
 | Copy Line                 | Copy   | `SHIFT-Y`            |
 | Select Line               | Copy   | `SHIFT-V`            |

</details>

## General Binds

(Not Part of the dot files, but my personal binds)

| Action                     | Bind            |
| :------------------------- | :-------------- |
| Open Application Launcher      | `ALT-SPACE`       |
| Open Terminal (Kitty)      | `SUPER-T`       |
| Campure Rectangular Region | `SUPER-SHIFT-S` |
| Change Imput Language      | `ALT-SHIFT`     |

