" Plugins {{{
" Download vim-plug if missing
if empty(glob("~/.vim/autoload/plug.vim"))
    silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * silent! PlugInstall
endif

" declare plugins
silent! if plug#begin()

" Common
Plug 'PeterRincker/vim-argumentative'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'bling/vim-airline'
Plug 'dense-analysis/ale'
Plug 'duggiefresh/vim-easydir'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/vim-easy-align'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'markonm/traces.vim'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'preservim/nerdtree'
Plug 'rhysd/clever-f.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sgur/vim-editorconfig'
Plug 'srstevenson/vim-picker'
Plug 'thinca/vim-quickrun'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
Plug 'vim-utils/vim-man'
Plug 'wincent/ferret'
Plug 'xolox/vim-misc'

" Vim testing
Plug 'junegunn/vader.vim'
Plug 'kana/vim-vspec'

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'

" Colorschemes
Plug 'flazz/vim-colorschemes'

" Comments
Plug 'tpope/vim-commentary'

" Code completion
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/deoplete-phpactor'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sniphpets/sniphpets'
Plug 'sniphpets/sniphpets-common'
Plug 'sniphpets/sniphpets-doctrine'
Plug 'sniphpets/sniphpets-phpunit'
Plug 'sniphpets/sniphpets-postfix-codes'
Plug 'sniphpets/sniphpets-symfony'
Plug 'voronkovich/ultisnips-vue'

" PHP
Plug '2072/PHP-Indenting-for-VIm'
Plug 'StanAngeloff/php.vim'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'evidens/vim-twig'
Plug 'phpactor/phpactor', { 'do': 'composer install --no-dev -o -n' }
Plug 'rayburgemeestre/phpfolding.vim'

" JS
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install tern' }
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'

" Html
Plug 'AndrewRadev/tagalong.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'mattn/emmet-vim'

" CSS
Plug 'ap/vim-css-color'

" ZSH highlighting
Plug 'clones/vim-zsh'

" Ansible
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

" C
Plug 'bfrg/vim-cpp-modern'
Plug 'xaizek/vim-inccomplete'
Plug 'zhaohuaxishi/ctrlp-header'
call plug#end()
endif
" }}}

" Common settings {{{1
set nobackup
set noswapfile

filetype plugin indent on

syntax on

let mapleader = ","
let maplocalleader="\\"

nnoremap ; :

" Quit insert mode
inoremap jf <Esc>
inoremap fj <Esc>

" nnoremap <C-z> <Nop>

" Launch shell command
nnoremap ! :!

" Colorscheme
set t_Co=256
set background=dark
colo earth
hi Pmenu ctermfg=0 ctermbg=100
hi PmenuSel ctermfg=90 ctermbg=100

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

set number
set wildmenu
set wildmode=longest,list,full

" Jump to an end of a string
inoremap ,a <C-o>A
inoremap ;a <C-o>o

" Disable <Arrow keys> {{{
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
" }}}

" Centering search result {{{2
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" 2}}}

" Centering after moving to the mark
" https://www.reddit.com/r/vim/comments/80vutj/how_to_center_screen_after_moving_to_a_mark/duz2t0k/
nnoremap <expr> ' "'" . nr2char(getchar()) . "zz"
nnoremap <expr> ` "`" . nr2char(getchar()) . "zz"

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vr :so $MYVIMRC<CR>

" Write file with root permissions
command! W w !sudo tee %

" Man viewer
set keywordprg=:Man

" Working with buffers {{{2
nnoremap <Leader>q :Bdelete<CR>
nnoremap <C-h> <C-^> " Toggle between two buffers
" 2}}}

" Substitute functions {{{2
nnoremap <leader>s :%s//<left>
function! Replace(string)
    let replace = input("Replace " . a:string . " with: ")
    :exe '%s/\<' . a:string . '\>/' .  replace
endfunction
nnoremap <leader>r :call Replace(expand('<cword>'))<CR>
nnoremap <leader>R :call Replace(expand('<cWORD>'))<CR>
" 2}}}
" 1}}}

set path=**
au FileType c,cpp setlocal path=.,/usr/include,/usr/include/x86_64-linux-gnu,,
set wildignore+=*/vendor/*,*/node_modules/*,*/var/*,*/public/build/*

" Ultisnips {{{
let g:UltiSnipsSnippetDirectories=[ "UltiSnips", $HOME.'/.vim/UltiSnips' ]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:snips_author = "Oleg Voronkovich <oleg-voronkovich@yandex.ru>"
let g:snips_author_url = "https://github.com/voronkovich"
" }}}

" Airline
set laststatus=2

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.php = [ '->', '::', '(', 'use ', 'namespace ', '\' ]

" Deoplete
let g:deoplete#enable_at_startup = 1

" NERDTree
nnoremap <BS> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1

" vim-test
nnoremap <Leader>t :TestNearest<CR>
nnoremap <Leader>Tf :TestFile<CR>
nnoremap <Leader>Tl :TestLast<CR>
nnoremap <Leader>Ts :TestSuite<CR>
nnoremap <Leader>Tv :TestVisit<CR>
let g:test#runner_commands = ['PHPUnit']
let test#php#phpunit#options = { 'file': '--testdox' }
let test#php#phpspec#options = '--format=pretty'
function! CustomTransform(cmd) abort
    if filereadable('.ddev/config.yaml')
        return 'ddev exec -- '.a:cmd
    endif

    if executable('symfony') && filereadable('symfony.lock')
        if stridx(a:cmd, 'phpunit') > -1
            return 'SYMFONY_DEPRECATIONS_HELPER="disabled=1" symfony php '.a:cmd
        endif

        return 'symfony run -- '.a:cmd
    endif

    return a:cmd
endfunction
let g:test#custom_transformations = {
    \ 'custom': function('CustomTransform'),
\ }
let g:test#transformation = 'custom'

" Saving by Ctrl+a
nnoremap <C-a> <Esc>:w<CR>
inoremap <C-a> <Esc>:w<CR>

" IDE like autocompletion with C-<Space>
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" Guttentags
let g:gutentags_project_root = [ 'vendor/composer' ]

" CtrlP {{{
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0
let g:ctrlp_match_window = 'max:20'
let g:ctrlp_working_path_mode = 0
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -iU --nocolor --nogroup --hidden
          \ --ignore "**/*.pyc"
          \ --ignore "**/.*.swp"
          \ --ignore ".DS_Store"
          \ --ignore ".git"
          \ --ignore ".hg"
          \ --ignore ".local_repo"
          \ --ignore ".phpcd"
          \ --ignore ".svn"
          \ --ignore "app/cache"
          \ --ignore "bin"
          \ --ignore "build"
          \ --ignore "node_modules"
          \ --ignore "public/bundles"
          \ --ignore "var/cache"
          \ --ignore "var/data"
          \ --ignore "vendor"
          \ --ignore "web/bundles"
          \ -g ""'
endif
let g:ctrlp_extensions = ['funky', 'nerdtree']
nnoremap <Space><BS> :CtrlPNerdTree<CR>
nnoremap <Space>/ :CtrlPLine<CR>
nnoremap <CR>   :CtrlP<CR>
nnoremap <Leader>f :CtrlPFunky<CR>
" }}}

" Picker/Fzy
nnoremap <CR> :PickerEdit<CR>
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ':PickerEdit<CR>'
nnoremap <Space>l :PickerBuffer<CR>

" Easy motion
let g:EasyMotion_leader_key = '<Space>'

" ALE {{{
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_fixers = {
    \ 'php': [
        \ 'php_cs_fixer',
        \ 'trim_whitespace',
        \ 'remove_trailing_lines'
    \ ]
\ }
" Fix code style
command! CS ALEFix
nnoremap <Leader>cs :CS<CR>

let g:airline#extensions#ale#enabled = 1

let g:ale_php_phpcs_standard = 'psr2'
" }}}

" Easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Projectionist
nnoremap <Leader>a :A<CR>
nnoremap <Leader>e :E
let g:projectionist_heuristics = {
    \ '*': {
        \ '*.c': {
            \ 'type': 's',
            \ 'alternate': '{}.h',
        \ },
        \ '*.h': {
            \ 'type': 'h',
            \ 'alternate': '{}.c',
        \ },
    \ },
    \ 'config/bundles.php': {
        \ 'src/Command/*Command.php': {
            \ 'type': 'command',
            \ 'skeleton': 'sfcommand',
        \ },
        \ 'src/Controller/*Controller.php': {
            \ 'type': 'controller',
            \ 'skeleton': 'sfcontroller',
        \ },
        \ 'src/DataFixtures/*Fixtures.php': {
            \ 'type': 'fixture',
            \ 'skeleton': 'sffixture',
            \ 'alternate': 'src/Entity/{}.php',
        \ },
        \ 'src/Entity/*.php': {
            \ 'type': 'entity',
            \ 'skeleton': 'sfentity',
            \ 'alternate': [
                \ 'src/Repository/{}Repository.php',
                \ 'src/Controller/{}Controller.php',
                \ 'src/Controller/Admin/{}Controller.php',
                \ 'src/Factory/{}Factory.php',
                \ 'src/Form/{}Type.php'
            \ ],
        \ },
        \ 'src/Events.php': {
            \ 'type': 'events',
        \ },
        \ 'src/Event/*Event.php': {
            \ 'type': 'event',
            \ 'skeleton': 'sfevent',
        \ },
        \ 'src/EventSubscriber/*Subscriber.php': {
            \ 'type': 'subscriber',
            \ 'skeleton': 'sfsubscriber',
        \ },
        \ 'src/Exception/*Exception.php': {
            \ 'type': 'exception',
        \ },
        \ 'src/Factory/*Factory.php': {
            \ 'type': 'factory',
            \ 'alternate': 'src/Entity/{}.php',
        \ },
        \ 'src/Form/*Type.php': {
            \ 'type': 'form',
            \ 'alternate': 'src/Entity/{}.php',
            \ 'skeleton': 'sfform',
        \ },
        \ 'src/Repository/*Repository.php': {
            \ 'type': 'repository',
            \ 'alternate': 'src/Entity/{}.php',
            \ 'skeleton': 'sfrepository',
        \ },
        \ 'src/MessageHandler/*Handler.php': {
            \ 'type': 'handler',
            \ 'alternate': 'src/Message/{}.php',
            \ 'skeleton': 'sfhandler',
        \ },
        \ 'src/Message/*.php': {
            \ 'type': 'message',
            \ 'alternate': 'src/MessageHandler/{}Handler.php',
        \ },
        \ 'src/Migrations/Version*.php': {
            \ 'type': 'migration',
        \ },
        \ 'src/Validator/*.php': {
            \ 'type': 'constraint',
            \ 'alternate': 'src/Validator/{}Validator.php',
            \ 'skeleton': 'sfconstraint',
        \ },
        \ 'src/Validator/*Validator.php': {
            \ 'type': 'validator',
            \ 'alternate': 'src/Validator/{}.php',
            \ 'skeleton': 'sfvalidator',
        \ },
        \ 'src/Twig/*Extension.php': {
            \ 'type': 'twig',
            \ 'skeleton': 'sftwigextension',
        \ },
        \ 'src/Helper/*.php': {
            \ 'type': 'helper',
        \ },
        \ 'src/Util/*.php': {
            \ 'type': 'util',
        \ },
        \ 'src/Kernel.php': {
            \ 'type': 'kernel',
        \ },
        \ 'templates/*.html.twig': {
            \ 'type': 'template',
            \ 'skeleton': 'sftemplate',
        \ },
        \ 'config/bundles.php': {
            \ 'type': 'bundles',
        \ },
        \ 'config/packages/*.yaml': {
            \ 'type': 'config',
            \ 'template': '{basename}:',
        \ },
        \ 'config/packages/easy_admin/entities/*.yaml': {
            \ 'alternate': 'src/Entity/{basename}.php',
            \ 'type': 'easyadmin',
            \ 'template': [
                \ 'easy_admin:',
                \ '    entities:',
                \ '        {basename}:',
                \ '            class: App\Entity\{basename}',
                \ ],
        \ },
        \ 'config/routes/*.yaml': {
            \ 'type': 'routing',
            \ 'template': '{basename}:',
        \ },
        \ 'config/routes.yaml': {
            \ 'type': 'routes',
        \ },
        \ 'config/services.yaml': {
            \ 'type': 'services',
        \ },
        \ 'translations/*.xlf': {
            \ 'type': 'translation',
        \ },
        \ 'assets/styles/*.css': {
            \ 'type': 'astyle',
        \ },
        \ 'assets/lib/*.js': {
            \ 'type': 'alib',
        \ },
        \ 'assets/components/*.js': {
            \ 'type': 'acomponent',
            \ 'skeleton': 'wcbase',
        \ },
        \ 'assets/controllers/*_controller.js': {
            \ 'type': 'acontroller',
            \ 'skeleton': 'stcontroller',
        \ },
        \ 'var/log/*.log': {
            \ 'type': 'log',
        \ },
    \ },
    \ 'composer.json&src/': {
        \ 'src/*.php': {
            \ 'type': 'src',
            \ 'skeleton': 'class',
        \ },
        \ 'src/Exception/*Exception.php': {
            \ 'type': 'exception',
            \ 'skeleton': 'class',
        \ },
    \ },
    \ 'composer.json&src/&tests/': {
        \ 'src/*.php': {
            \ 'type': 'src',
            \ 'skeleton': 'class',
            \ 'alternate': [
                \ 'tests/{}Test.php',
            \ ],
        \ },
        \ 'tests/*Test.php': {
            \ 'type': 'test',
            \ 'skeleton': 'pucase',
            \ 'alternate': 'src/{}.php',
        \ },
    \ },
    \ 'composer.json&src/&tests/unit/': {
        \ 'src/*.php': {
            \ 'type': 'src',
            \ 'skeleton': 'class',
            \ 'alternate': [
                \ 'tests/unit/{}Test.php',
            \ ],
        \ },
        \ 'tests/unit/*Test.php': {
            \ 'type': 'test',
            \ 'skeleton': 'pucase',
            \ 'alternate': 'src/{}.php',
        \ },
    \ },
    \ 'composer.json&src/&spec/': {
        \ 'src/*.php': {
            \ 'type': 'src',
            \ 'skeleton': 'class',
            \ 'alternate': [
                \ 'spec/{}Spec.php',
            \ ],
        \ },
        \ 'spec/*Spec.php': {
            \ 'type': 'test',
            \ 'alternate': 'src/{}.php',
        \ },
    \ },
    \ 'composer.json&src/&specs/': {
        \ 'src/*.php': {
            \ 'type': 'src',
            \ 'skeleton': 'class',
            \ 'alternate': [
                \ 'specs/{}.spec.php',
            \ ],
        \ },
        \ 'specs/*.spec.php': {
            \ 'type': 'test',
            \ 'skeleton': 'pdspec',
            \ 'alternate': 'src/{}.php',
        \ },
    \ },
    \ 'src/App.vue': {
        \ 'src/*.js': {
            \ 'type': 'src',
            \ 'alternate': 'tests/unit/{}.spec.js',
        \ },
        \ 'src/components/*.vue': {
            \ 'type': 'component',
            \ 'alternate': 'tests/unit/components/{}.spec.js',
        \ },
        \ 'src/composables/*.js': {
            \ 'type': 'composable',
        \ },
        \ 'src/views/*.vue': {
            \ 'type': 'view',
        \ },
        \ 'tests/unit/*.spec.js': {
            \ 'type': 'test',
            \ 'alternate': 'src/{}.js',
        \ },
        \ 'tests/unit/components/*.spec.js': {
            \ 'alternate': 'src/components/{}.vue',
        \ },
    \ },
\ }

" Ferret
nnoremap <localleader>a :Ack 

" PHP {{{
au FileType php setlocal keywordprg=psysh-doc
au FileType php setlocal matchpairs=(:),{:},[:]

" Phpactor
au FileType php setlocal omnifunc=phpactor#Complete
au FileType php nnoremap gd :call phpactor#GotoDefinition()<CR>
au FileType php nnoremap <Leader>m :call phpactor#ContextMenu()<CR>
au FileType php nnoremap <Leader>ua :call phpactor#UseAdd() <bar> :call PhpSortUse()<CR>
au FileType php nnoremap <Leader>um :call phpactor#ImportMissingClasses() <bar> :call PhpSortUse()<CR>
au FileType php nnoremap <Leader>us :call PhpSortUse()<CR>

" PHP folding
let php_folding=0

" Advanced highlighting
function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction
augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END

" Sniphpets
let g:sniphpets_strict_types = 1
" }}}

" Doge
let g:doge_mapping_comment_jump_forward = '<C-j>'
let g:doge_mapping_comment_jump_backward = '<C-k>'

" File skeletons based on Ultisnips {{{
" See: https://subvisual.co/blog/posts/135-super-powered-vim-part-iii-skeletons/
augroup UltiSnips_custom
    autocmd!
    autocmd BufNewFile * silent! call InsertSkeleton()
augroup END

function! s:try_insert(skel)
    execute "normal! i" . a:skel . "\<C-r>=UltiSnips#ExpandSnippet()\<CR>"

    if g:ulti_expand_res == 0
        silent! undo
        return
    endif

    " enter insert mode and advance cursor (equivalent to typing `a` instead of `i`)
    execute "startinsert"
    call cursor( line('.'), col('.') + 1)

    return g:ulti_expand_res
endfunction

function! InsertSkeleton() abort
    let filename = expand('%')

    " abort on non-empty buffer or exitant file
    if !(line('$') == 1 && getline('$') == '') || filereadable(filename)
        return
    endif

    if !empty('b:projectionist')
        " Loop through projections with 'skeleton' key and try each one until the
        " snippet expands
        for [root, value] in projectionist#query('skeleton')
            echo value
            if s:try_insert(value)
                return
            endif
        endfor
    endif

    call s:try_insert('skel')
endfunction
" }}}

" vim: foldmethod=marker
