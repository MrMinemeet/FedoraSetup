# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source /usr/local/bin/antigen.zsh
ZSH_THEME="robbyrussell"

# Load oh-my-zsh lib
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle command-not-found

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting # has to be the last bundle!

# Apply antigen things
antigen apply

# Which plugins would you like to load?
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Load custom alias file
if [[ -e ~/.config/aliases ]]; then
        source ~/.config/aliases
fi

# TODO: Load Theme
#eval "$(oh-my-posh init zsh --config ~/.config/themes/style.omp-json)"
