# Environment ariables {{{
export PATH="$PATH:${HOME}/.local/bin:${HOME}/.gem/bin:${HOME}/.composer/vendor/bin:${HOME}/.symfony/bin:vendor/bin:node_modules/.bin"
# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
export LC_ALL=en_US.UTF-8
export EDITOR=vim
export MANPAGER='most'
export PROJECTS="${HOME}/projects"
export PROJECTS_TMP="/run/user/$(id -u)/projects"
# }}}

# Bootstrap {{{
source ~/.zplug/init.zsh

omz() { zplug "plugins/$1", from:oh-my-zsh; }
# }}}

# Bundles {{{
omz composer
omz extract
omz git
omz github
omz npm
omz vagrant
omz yarn
zplug "aperezdc/zsh-fzy"
zplug "mafredri/zsh-async", defer:0
zplug "sindresorhus/pure", as:theme, use:pure.zsh
zplug "supercrabtree/k"
zplug "voronkovich/gitignore.plugin.zsh"
zplug "voronkovich/phpcs.plugin.zsh"
zplug "voronkovich/phpunit.plugin.zsh"
zplug "voronkovich/project.plugin.zsh"
zplug "voronkovich/symfony.plugin.zsh"
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions", use:src
zplug 'molovo/revolver', as:command, use:revolver
zplug 'voronkovich/mysql.plugin.zsh'
zplug 'willghatch/zsh-snippets'
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zunit-zsh/zunit', as:command, use:zunit, hook-build:'./build.zsh'
# }}}

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# History settings {{{
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt hist_ignore_all_dups
setopt share_history
# }}}

# Aliases {{{
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ack="ag"
alias alpine='docker run -it --rm alpine'
alias ubuntu='docker run -it --rm ubuntu'
alias phpinsights='docker run -it --rm -v "$(pwd):/app" nunomaduro/phpinsights'
alias phars='/bin/sh -c "cd ~/.phive && phive status"'
alias d='docker'
alias dc='docker-compose'
alias di='docker images'
alias dop='docker-compose stop'
alias dp='docker ps'
alias dpa='docker ps -a'
alias dpl='docker ps -l'
alias dr='docker run'
alias drr='docker run --rm'
alias dup='docker-compose up'
alias dub='docker-compose up --build'
alias e="$EDITOR"
alias ytmp3='youtube-dl -x --audio-format=mp3'
alias ytm4a='youtube-dl -f m4a'
alias ytlist='youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s"'
alias gs='git status -sb'
alias sfdql="bin/console d:q:d"
alias ide="tmux -2 new-session $EDITOR \; split-window \; resize-pane -D 4"
alias k='k -h'
alias la='ls -lah'
alias ll='ls -lG'
alias localhost8080='sudo iptables -t nat -A OUTPUT -d localhost -p tcp --dport 80 -j REDIRECT --to-port 8080'
alias ls='ls --color=auto'
alias m='make'
alias pt='p -t'
alias phpspec='vendor/bin/phpspec'
alias root='sudo -s'
alias v="vagrant"
alias vb='virtualbox'
alias vim="stty stop '' -ixoff ; vim"
alias vspec=~/.vim/plugged/vim-vspec/bin/vspec
alias zshrc-reload="source ~/.zshrc"
alias zshrc="$EDITOR ~/.zshrc"
alias vpn="sudo protonvpn connect --fastest"
alias vpnd="sudo protonvpn disconnect"
alias vpns="protonvpn status"
alias dsymfony='docker-compose exec php bin/console'
alias dcomposer='docker-compose exec php composer'
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
ddev-install() {
    curl https://raw.githubusercontent.com/drud/ddev/master/scripts/install_ddev.sh | bash
}
ddev-update() {
    ddev-install
}
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
smoke() {
    wget \
        --recursive \
        --level 0 \
        --spider \
        --no-directories \
        --no-verbose \
        "${1:-localhost:8000}"
}
dsh() {
    docker exec -it "${1:-$(docker ps -ql)}" "${2:-sh}"
}
compdef __docker_complete_running_containers dsh
# }}}

# Automatically run ls on blank line for faster navigation {{{
auto-ls () {
    if [[ -z $BUFFER ]]; then
        zle -I
        k
        echo
    else
        zle ".$WIDGET"
    fi
}
zle -N accept-line auto-ls
zle -N other-widget auto-ls
# }}}

# ^Z to foreground the last suspended job {{{
# https://github.com/Peeja/ctrl-zsh
foreground-current-job() { fg; }
zle -N foreground-current-job
bindkey -M emacs '^z' foreground-current-job
bindkey -M viins '^z' foreground-current-job
bindkey -M vicmd '^z' foreground-current-job
# }}}

# Enable Emacs keybindings
# See https://superuser.com/a/751378
bindkey -e

bindkey '^ ' autosuggest-accept

if [[ -r $HOME/.zsh_custom ]]; then
    source $HOME/.zsh_custom
fi

# Symfony console autocompletion
eval "$(symfony-autocomplete)"
compdef _symfony manalize
compdef _symfony peridot
compdef _symfony phpactor
compdef _symfony phpstan
compdef _symfony phpunit-watcher
compdef _symfony phpspec
compdef _symfony phive

# Fuzzy
bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget
bindkey '^R'  fzy-history-widget

bindkey '\eg' snippet-expand

# vim: foldmethod=marker
