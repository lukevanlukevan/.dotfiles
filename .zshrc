# Source zshenv for environment variables and aliases

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# ... (other theme and plugin settings) ...
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# ... (other interactive shell configurations) ...

eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/Takuya.omp.json)"
eval "$(zoxide init zsh)"
# eval "$(/opt/homebrew/bin/brew shellenv)"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lukevan/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/Users/lukevan/miniforge3/etc/profile.d/conda.sh" ]; then
    . "/Users/lukevan/miniforge3/etc/profile.d/conda.sh"
  else
    export PATH="/Users/lukevan/miniforge3/bin:$PATH"
  fi
fi
unset __conda_setup

if [ -f "/Users/lukevan/miniforge3/etc/profile.d/mamba.sh" ]; then
  . "/Users/lukevan/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# aliases
zvim() {
  z $1
  nvim
}
