# Programs

The dotfiles/ directory is located in `$HOME/git/dotfiles`.

## Ranger

Ranger is used for the primary terminal file manager with:

 |                  |                                                                    |
 | :-               | :-                                                                 |
 | Image display    | Kitty                                                              |
 | Markdown Preview | [glow](https://github.com/charmbracelet/glow)                      |
 | Dev Icons        | [dev-icons](https://github.com/alexanderjeurissen/ranger_devicons) |

## Neovim

Neovim is used as the go-to text editor. The configuration is built on top of the [kickstart](https://github.com/nvim-lua/kickstart.nvim) project.

### Plugins

| Plugin                                                                              | Purpose                                  |
| :-                                                                                  | :-                                       |
| [Alpha](https://github.com/goolord/alpha-nvim)                        | Startup menu                   |
| [Lualine](https://github.com/nvim-lualine/lualine.nvim)                             | Fancy statusline                                        |
| [Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua)                             | File explorer                            |
| [Tabular](https://github.com/godlygeek/tabular)                                     | :Tabularize /\[symbol\] to align text    |
| [Comment](https://github.com/numToStr/Comment.nvim)                                 | Comment macro                            |
| [Rainbow-Delimiters](https://github.com/HiPhish/rainbow-delimiters.nvim)            | Matching delimiters are colored the same |
| [Auto-Pair](https://github.com/windwp/nvim-autopairs)                               | Automatically pair delimiters            |
| [Tiny-Inline_diagnostic](https://github.com/rachartier/tiny-inline-diagnostic.nvim) | Prettier diagnostic messages             |
| [Trouble](https://github.com/folke/trouble.nvim)                                    | Quickfix list navigation                 |
| [Conform](https://github.com/stevearc/conform.nvim)                                 | Code formatting                          |
| [Todo-Comments](https://github.com/folke/todo-comments.nvim)                        | Highlight TODO in comments               |
| [Nvim-Ufo](https://github.com/kevinhwang91/nvim-ufo)                                | Fold manager                             |
| [Neominimap](https://github.com/plugins.neominimap)                                 | Code Minimap                             |
| [Render-Markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim)     | Render markdown files in editor          |
| [Nvim-Colorizer](https://github.com/NvChad/nvim-colorizer.lua)                      | Color Text Inline                        |

### Git

| Plugin                                                 | Purpose      |
| :----------------------------------------------------- | :----------- |
| [Fugitive](https://github.comtpope/vim-fugitive)       |              |
| [Rhubarb](https://github.com/tpope/vim-rhubarb)        |              |
| [Diffview](https://github.com/sindrets/diffview.nvim)  | Merge Editor |
| [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) |              |

## Kitty 

The Kitty terminal emulator is used as the default terminal.
The terminal color scheme is inspired by [Blood Moon](https://github.com/dguo/blood-moon)..
The [Hack](https://github.com/source-foundry/Hack) typeface is the default monospaced font.

## General

 (Not Part of the dot files, but my personal binds)

 | Action                     | Bind            |
 | :------------------------  | :----------     |
 | Open Terminal (Kitty)  | `SUPER+T`       |
 | Campure Rectangular Region | `SUPER+SHIFT+S` |
 | Change Imput Language      | `ALT+SHIFT`     |
 | Spotify Pause Play         | `ALT+END`       |
 | Spotify Next               | `ALT+PG-UP`     |
 | Spotify Previous           | `ALT+PG-DN`     |

## Zshell

Zshell with `vi` mode enabled and the plugins:

[zsh-Autocomplete](https://github.com/marlonrichert/zsh-autocomplete.git)
[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
[zsh-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
[reverse-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
[zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode.git)

The Prompt is managed using [starship](starship.rc).

The [pipes.sh](https://github.com/pipeseroni/pipes.sh) is set as the inactivity terminal screen saver (default after 300 seconds).


  | Action                  | Mode        | Bind                 |
  | :------                 | :---------- | :-----------         |
  | Enter Normal Mode       | Insert      | `Esc`                |
  | Enter Insert Mode       | Normal      | `i`,`a`,`o`          |
  | Search Histroy Prefixed | Insert      | `CTRL+Q`, `CTRL+P`   |
  | Search Histtory Prefiex | Normal      | `SHIFT+J`, `SHIFT+K` |
  | Edit in Text Editor     | Visual      | `vvv`                |

## Neovim Binds

  | Action                  | Mode        | Bind                                                      |
  | :---------------------- | :---------- | :----------                                               |
  | Leader     | Normal      | `<space>`                                                   |
  | Open Which-Key Menu     | Normal      | `<leader>`                                                   |
  | Toggle Bool Value       | Normal      | `<ctrl>x / <ctrl>a`                                         |
  | Toggle Relative-Numbers | Normal      | ``<ctrl>\```                                               |
  | Navigate Buffers        | Normal      | `<alt>l`, `<alt>h`, `<alt><shift>l`, `<alt><shift>h`, `<leader>b` |
  | Surround Bind          | Normal      | `s` eg. `sr`, `sd`, `sa` for replace, delete, add.        |


### LaTex In Noevim

The TeX distribution chosen is: [TeX Live](https://tug.org/texlive/)
Integreted to Nvim with [VimTeX](https://github.com/lervag/vimtex)
Helpful [article](https://ejmastnak.com/tutorials/vim-latex/vimtex/)

The following are mainly to help my memory.
 | Action                         | Example                      | Mode   | Bind        |
 | :-                             | :-                           | :-     | :-          |
 | Which-Key Menu                 |                              | Normal | `l`         |
 | Paste Image (img-clip)                 |                              | Normal | `<leader>p`         |
 | Change Surrounding Environment | {enumerate} -> {itemize}     | Normal | `cse`       |
 | Delete Surrounding Environment |                              | Normal | `dse`       |
 | Delete Surrounding Command     | \sqrt\[b\]{a} -> a )         | Normal | `dsc`       |
 | Change Surrounding Command     | \textit{a} -> \textbf{a}     | Normal | `csc`       |
 | Toggle Surrounding Delimiters  | (a+b) -> \left(a + b \right) | Normal | `tsd`       |
 | Toggle Surrounding Fraction    | a/b -> \frac{a}{b}           | Normal | `tsf`       |
 | Close Environment              | \begin{env} +-> \end{env}    | Insert | `]]`        |
 | Prompt Create Matrix           | \begin{pmatrix} ...          | Normal | `<space>im` |
 | Prompt Create n-Cycle          | (a\_1 \\quad a\_2 ...)       | Normal | `<space>ic` |
 | Prompt Create List             | \begin{itemize} ...          | Normal | `<space>il` |
 | Synctex Inverse Search         | CTRL+M1 on Zathura to search | N/A    | `CTRL+M1`   |

For more default-keybinds: `:h vimtex-default-mappings`


### Python and R in Neovim

[ Quarto-nvim ](https://github.com/quarto-dev/quarto-nvim) is used for a notebook style environment for `R`, `Python` and `Julia`. 
[Slime](https://github.com/jpalardy/vim-slime) is used as a code runner.

  | Action                              | Mode   | Bind                  |
  | :-                                  | :-     | :-                    |
  | Which-Key Menu                      | Normal | `Q`                   |
  | Open Neovim Terminal (python and R) | Normal | `SPACE+cp` `SPACE+cr`
  | Send code to terminal               | Normal | `CTRL+cc`             |
  | Add Python / R codeblock            | Normal | `ALT+p`, `ALT+r`      |

# Packages:

- [bat](https://github.com/sharkdp/bat)
- [rainbowcsv](https://pypi.org/project/rainbowcsv/)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)

# Todo:

- Set up wine for stuff like paint.net
- switch off of Ranger to a different terminal file manager that is less slow and works better.
- Zshell "which-key" menu just like neovim's which-key plugin
- Look into Tmux
- Make actual installer
- Stylua and other formatters
- Hydra and the whichkey like menu
- neoorg - look into for note taking.
