# automatically check for updates in .dotfiles
~/bin/auto_update.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.dotfiles/antigen.zsh

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

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme romkatv/powerlevel10k

source ~/.aliases
source ~/.environment
source ~/.functions
# used for env variables that are not shared in .dotfiles repo
[ -f ~/.overrides ] && source ~/.overrides

# should be started after custom aliases are loaded
antigen bundle "MichaelAquilina/zsh-you-should-use"

# Tell Antigen that you're done.
antigen apply

source ~/.aliases

# show which alias to use when typing a long command
YSU_MESSAGE_POSITION="after"
# force usage of aliases:
# YSU_HARDCORE=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
