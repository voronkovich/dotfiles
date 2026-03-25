# Environment variables, sourced for every Zsh invocation.

export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export PROJECTS="${HOME}/projects"
export PROJECTS_TMP="${XDG_RUNTIME_DIR}/projects"
export DOKKU_HOST=dokku
export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep"
export AICOMMIT_CMD='ai --model groq:openai/gpt-oss-120b --prompt'

export GOOGLE_CLOUD_PROJECT=gen-lang-client-0273337949

# NVM
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true

# phpenv
export PHPENV_ROOT="${HOME}/.phpenv"
