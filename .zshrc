# Bootstrap {{{
source ~/.zplug/init.zsh

omz() { zplug "plugins/$1", from:oh-my-zsh; }
# }}}

# Bundles {{{
omz bower
omz composer
omz docker
omz extract
omz git
omz github
omz npm
omz vagrant
omz yarn
zplug "mafredri/zsh-async", defer:0
zplug "rg3/youtube-dl"
zplug "sindresorhus/pure", as:theme, use:pure.zsh
zplug "supercrabtree/k"
zplug "voronkovich/gitignore.plugin.zsh"
zplug 'voronkovich/mysql.plugin.zsh'
zplug "voronkovich/phpcs.plugin.zsh"
zplug "voronkovich/phpunit.plugin.zsh"
zplug "voronkovich/project.plugin.zsh"
zplug "voronkovich/symfony.plugin.zsh"
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions", use:src
# }}}

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Exporting variables {{{
export LC_ALL=en_US.UTF-8
export PATH="$PATH:${HOME}/bin:${HOME}/.composer/vendor/bin:${HOME}/.local/bin:vendor/bin:node_modules/.bin:${HOME}/.gem/ruby/current/bin"
export EDITOR=vim
export PAGER=most
export ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS="$HOME/.gitignore:$ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS"
# }}}

# History settings {{{
setopt hist_ignore_all_dups
# }}}

# Aliases {{{
alias ack="ag"
alias d='docker'
alias e="$EDITOR"
alias ide="tmux -2 new-session $EDITOR \; split-window \; resize-pane -D 4"
alias localhost8080='sudo iptables -t nat -A OUTPUT -d localhost -p tcp --dport 80 -j REDIRECT --to-port 8080'
alias m='make'
alias root='sudo -s'
alias v="vagrant"
alias vb='virtualbox'
alias vim="stty stop '' -ixoff ; vim"
alias vspec=~/.vim/bundle/vim-vspec/bin/vspec
alias zshrc-pull="echo '**** Pulling .zshrc'; git --git-dir ~/.zsh/.git --work-tree ~/.zsh pull; echo; antigen update; zshrc-reload"
alias zshrc-push="git --git-dir ~/.zsh/.git --work-tree ~/.zsh add . && git --git-dir ~/.zsh/.git --work-tree ~/.zsh commit && git --git-dir ~/.zsh/.git --work-tree ~/.zsh push"
alias zshrc-reload="source ~/.zshrc"
alias zshrc="$EDITOR ~/.zshrc"
if $(which htop &>/dev/null); then
    alias top=htop
fi
# }}}

# {{{ Hashes
hash -d desk=~/Desktop
hash -d docs=~/Documents
hash -d down=~/Downloads
hash -d logs=/var/log
# }}}

# Functions {{{
gac() {
    git add -A;
    git ls-files --deleted -z | xargs -r0 git rm;
    if [[ $# -gt 0 ]]; then
        git commit -m "$*"
    else
        git commit
    fi
}
genpass() {
    pwgen -0A ${1:-12} 1
}
upsearch () {
    slashes=${PWD//[^\/]/}
    directory="$PWD"
    for (( n=${#slashes}; n>0; --n ))
    do
        test -e "$directory/$1" && echo "$directory/$1" && return
        directory="$directory/.."
    done
}
fix-autocompletion() {
    compaudit | xargs -I % chmod g-w "%";
    compaudit | xargs -I % chown $USER "%";
    rm ~/.zcompdump*;
    compinit;
}
f() {
    find -iname "*$1*" -print -o -name '.git' -prune | grep -i --color "$1"
}
# }}}

# Automatically run ls on blank line for faster navigation {{{
auto-ls () {
    if [[ -z $BUFFER ]]; then
        zle -I
        k
    else
        zle ".$WIDGET"
    fi
}
zle -N accept-line auto-ls
zle -N other-widget auto-ls
# }}}

if [[ -r $HOME/.zsh_custom ]]; then
    source $HOME/.zsh_custom
fi

# vim: foldmethod=marker
