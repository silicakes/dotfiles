![image](https://github.com/silicakes/dotfiles/assets/1759539/ea871946-d7f1-4f76-a9c0-53c9f79cd7b9)

# dotfiles I'd like to keep.
Based on the [awesome tutorial](https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/) by Gabrielle Young

## Stuff I have here
1.  A neovim build with a minimal set of plugins, keybinding and mappings - using neovims [lspconfig](https://github.com/neovim/nvim-lspconfig).
    TODO: consider moving key mappings into a separate file and not a per-plugin basis.
2.  A hybrid vim / neovim configuration that will work on both using [coc.nvim](https://github.com/neoclide/coc.nvim) instead of lspoconfig.
    This is a single file for the vim config (`.vimrc`) and a [coc-settings.json](https://github.com/silicakes/dotfiles/blob/main/.config/nvim/coc-settings.json) to accompany all related LSP things.

### Installation (This should totally be automated):
```sh
echo ".dtf" >> .gitignore
git clone --bare git@github.com:silicakes/dotfiles.git $HOME/.dtf
alias dtf='/usr/bin/git --git-dir=$HOME/.dtf/ --work-tree=$HOME'
dtf config --local status.showUntrackedFiles no
dtf checkout
```
