# Environment ariables {{{
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${HOME}/.local/bin:${HOME}/.composer/vendor/bin:${HOME}/.symfony/bin:vendor/bin:node_modules/.bin:$PATH"
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -r rubygems -e 'puts "#{Gem.dir}/bin:#{Gem.user_dir}/bin"'):${PATH}"
fi

export LC_ALL=en_US.UTF-8
export EDITOR=vim
export MANPAGER='most'
export PROJECTS="${HOME}/projects"
export PROJECTS_TMP="${XDG_RUNTIME_DIR}/projects"
export DOKKU_HOST=dokku

ZSH_PLUGIN_DDEV_TOOLS=(composer yarn npm npx mysql psql console bin/console)
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
zplug "voronkovich/ddev.plugin.zsh"
zplug "voronkovich/gitignore.plugin.zsh"
zplug "voronkovich/phpcs.plugin.zsh"
zplug "voronkovich/phpunit.plugin.zsh"
zplug "voronkovich/project.plugin.zsh"
zplug "zdharma-continuum/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions", use:src
zplug 'molovo/revolver', as:command, use:revolver
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
alias youtube-dl='yt-dlp'
alias ytmp3='youtube-dl -x --audio-format=mp3'
alias ytm4a='youtube-dl -f m4a'
alias ytlist='youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s"'
alias gs='git status -sb'
alias sf="bin/console"
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
if which htop >/dev/null; then
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

__dokku_commands_list() {
    dokku --quiet help --all 2>/dev/null | \
        sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | \
        tr -cd '\11\12\15\40-\176' | \
        sed -nE 's/^\s*([-a-z:]+).*\s{2,}(\w.*)?$/\1 \u\2/p' | \
        sort -u
}

_dokku() {
    local cache="/tmp/${USER}-dokku-completions-4623c3e3-e3a2-403c-9422-12f4a135f07a"

    if [[ ! -f "$cache" ]]; then
        __dokku_commands_list | sed -E -e 's/:/\\:/' -e 's/\s/:/' > "$cache"
    fi

    IFS=$'\n' local -a commands=($(cat "$cache"))

    _describe 'commands' commands
}

compdef _dokku dokku

supa() {
    case $1 in
        psql )
            shift
            supabase-psql "$@"
            ;;
        pg_dump )
            shift
            supabase-pg_dump "$@"
            ;;
        studio )
            shift
            supabase-studio "$@" &>/dev/null
            ;;
        emails )
            shift
            supabase-emails "$@" &>/dev/null
            ;;
        * )
            supabase "$@"
            ;;
    esac
}

supabase-psql() {
    declare opts=''
    if [[ $# -gt 0 && ! "$@" == -* ]]; then
        opts='-c'
    fi

    command psql "$(supabase-postres-url)" ${opts} "$@"
}

supabase-curl() {
    declare -r apiKey="$(supabase-service-role-key)"

    command curl \
        -H "apikey: ${apiKey}" \
        -H "Authorization: Bearer ${apiKey}" \
        -H "Content-Type: application/json" \
        -H "Prefer: return=representation" \
        -X "${1:u}" \
        -d "${3}" \
        "http://localhost:54321/rest/v1/${2//\/}"
}

supabase-httpie() {
    command http \
        -A bearer -a "$(supabase-service-role-key)" \
        "http://localhost:54321/rest/v1/${*//\/}" \
        apiKey:"$(supabase-service-role-key)"
}

supabase-pg_dump() {
    command pg_dump "$(supabase-postres-url)" ${opts} "$@"
}

supabase-emails() {
    open "$(command supabase status | command sed -ne 's/\s*Inbucket URL:\s*//p')/monitor"
}

supabase-studio() {
    open "$(command supabase status | command sed -ne 's/\s*Studio URL:\s*//p')"
}

supabase-postres-url() {
    command supabase status | command grep -o 'postgresql://\S\+'
}

supabase-service-role-key() {
    command supabase status | command sed -ne 's/\s*service_role key:\s*//p'
}
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
if which symfony-autocomplete >/dev/null; then
    eval "$(symfony-autocomplete)"
    compdef _symfony manalize
    compdef _symfony peridot
    compdef _symfony phpactor
    compdef _symfony phpstan
    compdef _symfony phpunit-watcher
    compdef _symfony phpspec
    compdef _symfony phive
    compdef _symfony bin/console
fi

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# Fuzzy
bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget
bindkey '^R'  fzy-history-widget

bindkey '\eg' snippet-expand

# Pack completion
if which pack >/dev/null; then
    . $(pack completion --shell zsh)
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# vim: foldmethod=marker
