# dotbot-dotfiles

This are my dotfiles. Installer is based on https://github.com/anishathalye/dotbot

## Installation / Setup

``$ git clone https://github.com/kajmaj87/dotbot-dotfiles.git ~/.dotfiles``

``$ ~/.dotfiles/install``

Thats it! 

## Updating

When opening zsh, there will be an automatic fetch of the newest dotfiles version and afterwards the installer will run again automatically.
It may be worth reloading zsh after each update using "or" alias (oh-my-zsh reload).

When you have some pending changes, then you will also be notifed after opening zsh. You should commit and push any outstanding changes.

Both updating and pulling is automated as far as possible to force me to keep dotfiles always up to date.

Vim/Neovim will fetch all needed plugins each time you open them (this will only happen when there are some missing plugins)

## Notable contents

- fasd (use z, v aliases to quickly change directories or edit files you already edited with vim)
- fzf
- zsh with oh-my-zsh and powerlevel10k customized theme
- vim + neovim with separate configs (neovim uses vim configs and builds upon them)
