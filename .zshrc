# https://askubuntu.com/a/452576
stty sane stop ""

# Environment ariables {{{
if [[ -d "${HOME}/.phive/.local/bin" ]]; then
    path=( "${HOME}/.phive/.local/bin" $path )
fi
if [[ -d "${HOME}/.luarocks/bin" ]]; then
    path=( "${HOME}/.luarocks/bin" $path )
fi
if [[ -d "${HOME}/.local/share/bob/nvim-bin" ]]; then
    path=( "${HOME}/.local/share/bob/nvim-bin" $path )
fi

export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export PROJECTS="${HOME}/projects"
export PROJECTS_TMP="${XDG_RUNTIME_DIR}/projects"
export DOKKU_HOST=dokku
# }}}

# Bootstrap {{{
source ~/.zplug/init.zsh

omz() { zplug "plugins/$1", from:oh-my-zsh; }
# }}}

# Bundles {{{
omz brew
omz composer
omz extract
omz git
omz github
omz npm
omz vagrant
omz yarn
omz fancy-ctrl-z
omz magic-enter
zplug 'aperezdc/zsh-fzy'
zplug 'mafredri/zsh-async', defer:0
zplug 'sindresorhus/pure', as:theme, use:pure.zsh
zplug 'supercrabtree/k'
zplug 'voronkovich/ddev.plugin.zsh'
zplug 'voronkovich/gitignore.plugin.zsh'
zplug 'voronkovich/phpcs.plugin.zsh'
zplug 'voronkovich/project.plugin.zsh'
zplug 'voronkovich/symfony-complete.plugin.zsh'
zplug 'voronkovich/symfony.plugin.zsh'
zplug "${PROJECTS}/phpunit.plugin.zsh", from:local
zplug 'zdharma-continuum/fast-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions', use:src
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
alias dc='docker compose'
alias di='docker images'
alias dop='docker compose stop'
alias dp='docker ps'
alias dpa='docker ps -a'
alias dpl='docker ps -l'
alias dr='docker run'
alias drr='docker run --rm'
alias dup='docker compose up'
alias dupd='docker compose up -d'
alias dub='docker compose up --build'
alias devo='dev open'
alias devm='dev mails'
alias devd='dev dba'
alias e="$EDITOR"
alias epub='npx percollate epub'
alias procdev='foreman start --procfile=Procfile.dev'
alias youtube-dl='yt-dlp'
alias ytmp3='youtube-dl -x --audio-format=mp3'
alias ytm4a='youtube-dl -f m4a'
alias ytlist='youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s"'
alias gs='git status -sb'
alias sfmc='sf make:controller'
alias sfme='sf make:entity'
alias sfmf='sf make:form'
alias sfmt='sf make:test'
alias sfmm='sf make:migration'
alias sffl='sf doctrine:fixtures:load -n'
alias sflf='sf doctrine:fixtures:load -n'
alias sfdm='sf doctrine:migration:migrate'
alias sfdql='sf doctrine:query:dql'
alias sfsql='sf dbal:run-sql'
alias sfo='sf open'
alias sfom='sf mails'
alias signals='ps -o pid,comm,sig_pend,sig_catch,sig_block,sig_ignore'
alias ide="tmux -2 new-session $EDITOR \; split-window \; resize-pane -D 4"
alias k='k -h'
alias la='ls -lah'
alias ll='ls -lG'
alias lr='artisan'
alias lrcs='lr php vendor/bin/pint --test'
alias lrcsfix='lr php vendor/bin/pint'
alias lrpest='APP_ENV=testing lr php vendor/bin/pest'
alias lrroutes='lr route:list --except-vendor'
alias lrfresh='lr migrate:fresh --seed'
alias lro='lr open'
alias lrt='lr tinker'
alias lrmm='lr make:model -m'
alias lrmmi='lr make:migration'
alias lrmf='lr make:factory'
alias lrmc='lr make:controller'
alias lrmv='lr make:view'
alias localhost8080='sudo iptables -t nat -A OUTPUT -d localhost -p tcp --dport 80 -j REDIRECT --to-port 8080'
alias ls='ls --color=auto'
alias m='make'
alias man='viman'
alias pt='p -t'
alias phpspec='vendor/bin/phpspec'
alias proxy-start="systemctl --user start opera-proxy"
alias proxy-restart="systemctl --user restart opera-proxy"
alias proxy-status="systemctl --user status opera-proxy"
alias proxy-stop="systemctl --user stop opera-proxy"
alias root='sudo -s'
alias v="vagrant"
alias vb='virtualbox'
# alias vim="stty stop '' -ixoff ; vim"
alias vspec=~/.vim/plugged/vim-vspec/bin/vspec
alias vusted='VUSTED_USE_LOCAL=1 vusted tests'
alias zshrc-reload="source ~/.zshrc"
alias zshrc="$EDITOR ~/.zshrc"
alias zshrl="exec zsh"
alias wp='wp-cli'
alias woo='wp-cli wc'
alias dsymfony='docker-compose exec php bin/console'
alias dcomposer='docker-compose exec php composer'
if which htop >/dev/null; then
    alias top=htop
fi
if which batcat >/dev/null; then
    alias cat=batcat
    alias bat=batcat
fi
# }}}

# {{{ Hashes
hash -d desk=~/Desktop
hash -d docs=~/Documents
hash -d down=~/Downloads
hash -d nv=~/.config/nvim
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

paths() {
    local p; for p in "${path[@]}"; do; echo "${p}"; done;
}

fpaths() {
    local p; for p in "${fpath[@]}"; do; echo "${p}"; done;
}

localrun() {
    command ssh -R "80:localhost:${1:-8000}" nokey@localhost.run
}
# }}}

# Enable Emacs keybindings
# See https://superuser.com/a/751378
bindkey -e

bindkey '^ ' autosuggest-accept

# OMZ magic-enter
MAGIC_ENTER_GIT_COMMAND='k'
MAGIC_ENTER_OTHER_COMMAND='k'

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

# Ruby & Ruby Gems
if which ruby >/dev/null && which gem >/dev/null; then
    path+=( $(ruby -r rubygems -e 'puts "#{Gem.dir}/bin #{Gem.user_dir}/bin"') )
fi

# Symfony
# artisan() {
#     if [[ -x "${PWD}/vendor/bin/sail" ]]; then
#         SF_CONSOLE='artisan' SF_RUNNER='docker-compose exec -- laravel.test' sf "$@"
#     else
#         SF_CONSOLE='artisan' sf "$@"
#     fi
# }

compdef _sf artisan

compdef _symfony_complete console
compdef _symfony_complete laravel
compdef _symfony_complete composer
compdef _symfony_complete php-cs-fixer
compdef _symfony_complete phpstan
compdef _symfony_complete phpspec

# DDEV
ddev-tools wp-cli composer

# vim: foldmethod=marker

# BEGIN SNIPPET: Platform.sh CLI configuration
HOME=${HOME:-'/home/oleg'}
export PATH="$HOME/"'.platformsh/bin':"$PATH"
if [ -f "$HOME/"'.platformsh/shell-config.rc' ]; then . "$HOME/"'.platformsh/shell-config.rc'; fi # END SNIPPET
