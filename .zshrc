# https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#manual
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Enable Emacs keybindings
# See https://superuser.com/a/751378
bindkey -e

# https://askubuntu.com/a/452576
stty sane stop ""

# Environment ariables {{{
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export PROJECTS="${HOME}/projects"
export PROJECTS_TMP="${XDG_RUNTIME_DIR}/projects"
export DOKKU_HOST=dokku

# gpt4free
export GPT4FREE_API_BASE=http://localhost:1337/v1/
export OPENAI_API_BASE="${GPT4FREE_API_BASE}"
export OPENAI_API_KEY=secret
# }}}

if [[ -d "${HOME}/.phive/.local/bin" ]]; then
    path=( "${HOME}/.phive/.local/bin" $path )
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

# Plugins
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit light zsh-users/zsh-autosuggestions
bindkey '^ ' autosuggest-accept

zinit ice wait lucid atload"zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice as"program" pick"revolver"
zinit light molovo/revolver

zinit ice as"command" from"gh-r"
zinit light zunit-zsh/zunit

zinit ice wait lucid
zinit light lukechilds/zsh-nvm

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light supercrabtree/k

zinit light hmgle/aider-zsh-complete

zinit light voronkovich/ddev.plugin.zsh
ddev-tools wp-cli composer

zinit light voronkovich/gitignore.plugin.zsh

zinit light voronkovich/project.plugin.zsh

zinit ice wait lucid
zinit light voronkovich/symfony-complete.plugin.zsh
compdef _symfony_complete console
compdef _symfony_complete laravel
compdef _symfony_complete composer
compdef _symfony_complete php-cs-fixer
compdef _symfony_complete phpstan
compdef _symfony_complete phpspec

zinit ice wait lucid
zinit light voronkovich/symfony.plugin.zsh
compdef _sf artisan

zinit ice wait lucid
zinit light voronkovich/phpunit.plugin.zsh

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
# }}}

# History settings {{{
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt append_history
setopt hist_ignore_all_dups
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_space
# }}}

# Aliases {{{
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ack="ag"
alias codemod=codemod2
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
alias gpa='git remote | xargs -n1 git push'
alias gs='git status -sb'
alias gpt4free-start='systemctl --user start gpt4free'
alias gpt4free-restart='systemctl --user restart gpt4free'
alias gpt4free-status='systemctl --user status gpt4free'
alias gpt4free-stop='systemctl --user stop gpt4free'
alias gpt4free-chat='open http://localhost:1337/chat &>/dev/null'
alias gpt4free-docs='open http://localhost:1337/docs &>/dev/null'
alias procdev='foreman start --procfile=Procfile.dev'
alias youtube-dl='yt-dlp'
alias ytmp3='youtube-dl -x --audio-format=mp3'
alias ytm4a='youtube-dl -f m4a'
alias ytlist='youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s"'

alias signals='ps -o pid,comm,sig_pend,sig_catch,sig_block,sig_ignore'
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
alias mirror-site="httrack --footer '' --user-agent 'Mozilla/5.0 (compatible; SiteMirror)'"
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

# Aider
alias ai='aider'
alias aiask='aider --chat-mode ask'
alias ailint='aider --lint'
alias aitest='aider --test'
alias aicommit='aider --commit'
alias aiconf="${EDITOR} ${HOME}/.aider.conf.yml"
alias chat='aider --chat-mode ask --model openai/o1-mini --no-git --input-history-file=/dev/null --chat-history-file=/dev/null'

# Symfony
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
alias serve='symfony serve -d && symfony open:local'
alias serve-stop='symfony server:stop'
alias serve-log='symfony server:log'
alias composer='symfony composer'
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

aider() {
    if ! systemctl --user is-active --quiet gpt4free.service; then
        systemctl --user start gpt4free.service
    fi

    command aider "$@"
}

gpt() {
    if [[ "$#" -eq 0 ]]; then
        set -- '-i'
    fi

    tgpt "$@"
}

gpt4free() {
    if [[ "$#" -eq 0 ]]; then
        set -- '-i'
    fi

    tgpt \
        --provider openai \
        --model o1-mini \
        --url "${GPT4FREE_API_BASE}chat/completions" \
        --key "${OPENAI_API_KEY}" \
        "${@}"
}

chatgpt() {
    if [[ "$#" -eq 0 ]]; then
        set -- '-i'
    fi

    gpt4free --model o1-mini "${@}"
}
# }}}

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# fzf
fzf-files-widget() {
    local selected preview_cmd search_cmd

    if command -v batcat >/dev/null 2>&1; then
        preview_cmd='batcat --color=always --style=numbers --line-range=:500 {} 2>/dev/null'
    else
        preview_cmd='cat {} 2>/dev/null'
    fi

    if command -v rg >/dev/null 2>&1; then
        search_cmd="rg --files"
    else
        search_cmd="find . -type f -not -path '*/\.git/*'"
    fi

    selected="$(eval ${search_cmd} | fzf --height 50% --reverse \
        --prompt="Files> " \
        --bind 'ctrl-space:toggle+down' \
        --info=inline \
        --preview-window=right:50%:wrap \
        --preview "${preview_cmd}")"

    if [[ -n "${selected}" ]]; then
        LBUFFER="${LBUFFER}${(q)selected}"
    fi

    zle redisplay
}
zle -N fzf-files-widget
bindkey '^T' fzf-files-widget

# Pack completion
if which pack >/dev/null; then
    . $(pack completion --shell zsh)
fi

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

# NVM
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# BEGIN SNIPPET: Platform.sh CLI configuration
HOME=${HOME:-'/home/oleg'}
export PATH="$HOME/"'.platformsh/bin':"$PATH"
if [ -f "$HOME/"'.platformsh/shell-config.rc' ]; then . "$HOME/"'.platformsh/shell-config.rc'; fi # END SNIPPET

autoload -Uz compinit
compinit
# vim: foldmethod=marker
