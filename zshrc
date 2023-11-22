# automatically check for updates in .dotfiles
~/bin/auto_update.sh

source ~/.environment

[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh 

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
# antigen bundle zsh-users/zsh-completions
# antigen bundle docker/cli
# antigen bundle docker/compose
# znap source marlonrichert/zsh-autocomplete
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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
