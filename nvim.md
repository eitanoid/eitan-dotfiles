## Neovim

Nvim config is built on top of [kickstart](https://github.com/nvim-lua/kickstart.nvim).

### Plugins

<details>
   <summary> List of Plugins </summary>

| Plugin                                                                              | Purpose                                  |
| :---------------------------------------------------------------------------------- | :--------------------------------------- |
| [Alpha](https://github.com/goolord/alpha-nvim)                                      | Startup menu                             |
| [Lualine](https://github.com/nvim-lualine/lualine.nvim)                             | Fancy statusline                         |
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

- Kitty color scheme is inspired by [Blood Moon](https://github.com/dguo/blood-moon)
- I like the [Hack](https://github.com/source-foundry/Hack) typeface.



## Neovim Binds

| Action                  | Mode   | Bind                                                              |
| :---------------------- | :----- | :---------------------------------------------------------------- |
| Leader                  | Normal | `<space>`                                                         |
| Open Which-Key Menu     | Normal | `<leader>`                                                        |
| Toggle Nvim-Tree        | Normal | `<leader>f` or `\`                                                |
| Toggle Bool Value       | Normal | `<ctrl>x / <ctrl>a`                                               |
| Toggle Relative-Numbers | Normal | `<ctrl>\``                                                        |
| Navigate Buffers        | Normal | `<alt>l`, `<alt>h`, `<alt><shift>l`, `<alt><shift>h`, `<leader>b` |
| Surround Bind           | Normal | `s` eg. `sr`, `sd`, `sa` for replace, delete, add.                |

### LaTex In Noevim

The TeX distribution chosen is: [TeX Live](https://tug.org/texlive/)
Integreted to Nvim with [VimTeX](https://github.com/lervag/vimtex)
Helpful [article](https://ejmastnak.com/tutorials/vim-latex/vimtex/)

The following are mainly to help my memory.
| Action | Example | Mode | Bind |
| :- | :- | :- | :- |
| Which-Key Menu | | Normal | `l` |
| Paste Image (img-clip) | | Normal | `<leader>p` |
| Change Surrounding Environment | {enumerate} -> {itemize} | Normal | `cse` |
| Delete Surrounding Environment | | Normal | `dse` |
| Delete Surrounding Command | \sqrt\[b\]{a} -> a ) | Normal | `dsc` |
| Change Surrounding Command | \textit{a} -> \textbf{a} | Normal | `csc` |
| Toggle Surrounding Delimiters | (a+b) -> \left(a + b \right) | Normal | `tsd` |
| Toggle Surrounding Fraction | a/b -> \frac{a}{b} | Normal | `tsf` |
| Close Environment | \begin{env} +-> \end{env} | Insert | `]]` |
| Prompt Create Matrix | \begin{pmatrix} ... | Normal | `<space>im` |
| Prompt Create n-Cycle | (a_1 \\quad a_2 ...) | Normal | `<space>ic` |
| Prompt Create List | \begin{itemize} ... | Normal | `<space>il` |
| Synctex Inverse Search | CTRL+M1 on Zathura to search | N/A | `CTRL+M1` |

For more default-keybinds: `:h vimtex-default-mappings`

### Python and R in Neovim

[ Quarto-nvim ](https://github.com/quarto-dev/quarto-nvim) is used for a notebook style environment for `R`, `Python` and `Julia`.
[Slime](https://github.com/jpalardy/vim-slime) is used as a code runner.

| Action                              | Mode   | Bind                  |
| :---------------------------------- | :----- | :-------------------- |
| Which-Key Menu                      | Normal | `Q`                   |
| Open Neovim Terminal (python and R) | Normal | `SPACE+cp` `SPACE+cr` |
| Send code to terminal               | Normal | `CTRL+cc`             |
| Add Python / R codeblock            | Normal | `ALT+p`, `ALT+r`      |

# Tmux

Tmux pane switching is compatible with neovim splits using (nvim-tmux-navigator)[].

| Action      | Bind                    |
| :---------- | :---------------------- |
| Prefix Key  | `C+a`                   |
| Change pane | `C+h` `C+j` `C+k` `C+l` |

</details>

