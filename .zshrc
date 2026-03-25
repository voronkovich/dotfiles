# vim: foldmethod=marker

# ------------------------------------------------------------------------------
# ZINIT PLUGIN MANAGER
# https://github.com/zdharma-continuum/zinit
# ------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# ------------------------------------------------------------------------------
# SHELL OPTIONS & CORE UTILITIES
# ------------------------------------------------------------------------------
# Completions
autoload -Uz compinit
compinit

# Keybindings
bindkey -e

# Terminal settings
stty sane stop ""

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt append_history
setopt hist_ignore_all_dups
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_space


# ------------------------------------------------------------------------------
# PATH CONFIGURATION
# ------------------------------------------------------------------------------
# The order is important. Paths added first have higher precedence.

# Tool specific paths
if [[ -d "${HOME}/.phive/.local/bin" ]]; then
    path=( "${HOME}/.phive/.local/bin" $path )
fi
if [[ -d "${HOME}/.bun/bin" ]]; then
    path=( "${HOME}/.bun/bin" $path )
fi
if [[ -d "${HOME}/.luarocks/bin" ]]; then
    path=( "${HOME}/.luarocks/bin" $path )
fi
if [[ -d "${HOME}/.local/share/bob/nvim-bin" ]]; then
    path=( "${HOME}/.local/share/bob/nvim-bin" $path )
fi
if [[ -d "${HOME}/projects/ansibled/bin" ]]; then
    path=( "${HOME}/projects/ansibled/bin" $path )
fi

# phpenv
if [[ -d "${PHPENV_ROOT}" ]]; then
    path=( "${PHPENV_ROOT}/bin" $path)
    eval "$(phpenv init -)"
fi

# Ruby & Ruby Gems
if which ruby >/dev/null && which gem >/dev/null; then
    path+=( $(ruby -r rubygems -e 'puts "#{Gem.dir}/bin #{Gem.user_dir}/bin"') )
fi

# Platform.sh
export PATH="$HOME/"'.platformsh/bin':"$PATH"

# Local user binaries
if [[ -d "${HOME}/.local/bin" ]]; then
    path=( "${HOME}/.local/bin" $path )
fi

# ------------------------------------------------------------------------------
# PERSONAL ALIASES, FUNCTIONS, AND HASHES
# ------------------------------------------------------------------------------
# Aliases
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# Functions
if [ -f ~/.zsh_functions ]; then
    . ~/.zsh_functions
fi

# Directory Hashes
hash -d desk=~/Desktop
hash -d docs=~/Documents
hash -d down=~/Downloads
hash -d nv=~/.config/nvim
hash -d logs=/var/log

# ------------------------------------------------------------------------------
# ZINIT PLUGINS
# ------------------------------------------------------------------------------
# Prompt
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions
bindkey '^ ' autosuggest-accept

# Syntax Highlighting
zinit ice wait lucid atload"zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# Revolver
zinit ice as"program" pick"revolver"
zinit light molovo/revolver

# ZUnit
zinit ice as"command" from"gh-r"
zinit light zunit-zsh/zunit

# NVM
zinit ice wait lucid
zinit light lukechilds/zsh-nvm

# Completions
zinit ice wait lucid
zinit light zsh-users/zsh-completions

# k (directory listing)
zinit ice wait lucid
zinit light supercrabtree/k

# Aider
zinit light hmgle/aider-zsh-complete

# DDEV
zinit light voronkovich/ddev.plugin.zsh
ddev-tools wp-cli composer

# Gitignore
zinit light voronkovich/gitignore.plugin.zsh

# Project
zinit light voronkovich/project.plugin.zsh

# Symfony
zinit ice wait lucid
zinit light voronkovich/symfony-complete.plugin.zsh
compdef _symfony_complete console
compdef _symfony_complete laravel
compdef _symfony_complete composer
compdef _symfony_complete php-cs-fixer
compdef _symfony_complete phpstan
compdef _symfony_complete phpspec
if which symfony &>/dev/null; then
    . <(symfony completion)
fi

zinit ice wait lucid
zinit light voronkovich/symfony.plugin.zsh
compdef _sf artisan

# PHPUnit
zinit ice wait lucid
zinit light voronkovich/phpunit.plugin.zsh

# Oh My Zsh Snippets
zinit snippet OMZP::extract
zinit snippet OMZP::git
zinit snippet OMZP::github
zinit snippet OMZP::npm
zinit snippet OMZP::vagrant
zinit snippet OMZP::yarn
zinit snippet OMZP::brew
zinit snippet OMZP::composer
zinit snippet OMZP::fancy-ctrl-z
zinit snippet OMZP::magic-enter
MAGIC_ENTER_GIT_COMMAND='k'
MAGIC_ENTER_OTHER_COMMAND='k'

# ------------------------------------------------------------------------------
# TOOL-SPECIFIC CONFIGURATIONS
# ------------------------------------------------------------------------------
# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# fzf
if which fzf >/dev/null; then
    source <(fzf --zsh)
    export FZF_CTRL_T_COMMAND='rg --files'
    export FZF_CTRL_T_OPTS="
    --style=full
    --preview 'fzf-preview.sh {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi

# pack
if which pack >/dev/null; then
    . $(pack completion --shell zsh)
fi

# nvm (the zinit plugin is for loading, this is for direct use)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Platform.sh
if [ -f "$HOME/"'.platformsh/shell-config.rc' ]; then . "$HOME/"'.platformsh/shell-config.rc'; fi
