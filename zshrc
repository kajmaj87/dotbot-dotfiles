source ~/.dotfiles/antigen.zsh
source ~/.aliases
source ~/.environment
source ~/.functions

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle battery
antigen bundle python
antigen bundle stack
antigen bundle zsh-autosuggestions
antigen bundle fzf
antigen bundle command-not-found
antigen bundle alias-finder

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply

# show which alias to use when typing a long command
ZSH_ALIAS_FINDER_AUTOMATIC=true
