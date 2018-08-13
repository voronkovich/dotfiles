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
Plug 'duggiefresh/vim-easydir'
Plug 'easymotion/vim-easymotion'
Plug 'janko-m/vim-test'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/vim-easy-align'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'sgur/vim-editorconfig'
Plug 'srstevenson/vim-picker'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'voronkovich/file-magic.vim'
Plug 'w0rp/ale'
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
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sniphpets/sniphpets'
Plug 'sniphpets/sniphpets-common'
Plug 'sniphpets/sniphpets-doctrine'
Plug 'sniphpets/sniphpets-phpunit'
Plug 'sniphpets/sniphpets-peridot'
Plug 'sniphpets/sniphpets-postfix-codes'
Plug 'sniphpets/sniphpets-sylius'
Plug 'sniphpets/sniphpets-symfony'
Plug 'voronkovich/ultisnips-t3js'

" PHP
Plug '2072/PHP-Indenting-for-VIm'
Plug 'StanAngeloff/php.vim'
Plug 'afternoon/vim-phpunit'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'evidens/vim-twig'
Plug 'phpactor/phpactor', { 'do': 'composer install --no-dev -o -n' }
Plug 'rayburgemeestre/phpfolding.vim'
Plug 'tobyS/pdv'
Plug 'tobyS/vmustache'

" JS
Plug 'pangloss/vim-javascript'

" Html
Plug 'Valloric/MatchTagAlways'
Plug 'mattn/emmet-vim'

" ZSH highlighting
Plug 'clones/vim-zsh'

call plug#end()
endif
" }}}

" Common settings {{{1
set nobackup
set noswapfile

filetype plugin indent on

syntax on

let mapleader = ","

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

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vr :so $MYVIMRC<CR>

" Write file with root permissions
command! W w !sudo tee %

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

" Ultisnips {{{
let g:UltiSnipsSnippetDirectories=[ "UltiSnips", $HOME.'/.vim/UltiSnips' ]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}

" Airline
set laststatus=2

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.php = [ '->', '::', '(', 'use ', 'namespace ', '\' ]

" NERDTree
nnoremap <BS> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1

" vim-test
nnoremap <Leader>tf :TestFile<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tn :TestNearest<CR>
nnoremap <Leader>ts :TestSuite<CR>
nnoremap <Leader>tv :TestVisit<CR>
let test#php#phpunit#options = { 'file': '--testdox' }
" let test#php#phpunit#options = '--testdox'
let test#php#phpspec#options = '--format=pretty'

" Saving by Ctrl+a
nnoremap <C-a> <Esc>:w<CR>
inoremap <C-a> <Esc>:w<CR>

" FileMagic {{{
nnoremap <Leader>c :Create 
let g:file_magic_command_alias = 'Create'
let g:file_magic_open_command = 'e'
let g:file_magic_spells = {
    \ 'sfcontro': "src/AppBundle/Controller/%sController.php",
    \ 'sfentity': "src/AppBundle/Entity/%s.php",
    \ 'sfform':   "src/AppBundle/Form/Type/%sType.php",
    \ 'sflistener': "src/AppBundle/EventListener/%sListener.php",
    \ 'sfview':   "app/Resources/views/%s.twig",
    \ 'sfconf':   "app/config/%s.yml",
    \ 'here':     "!CreateHere",
    \ 'test':     "!CreateTest"
\ }
" Create file in the same directory as the current buffer
fun! CreateHere(key, file)
    let path = expand('%:p:h')

    if ! empty(path)
        return path . '/' . a:file
    else
        return a:file
    endif
endfun
" Create phpunit test
fun! CreateTest(key)
    let test_file = substitute(expand('%:p'), '/src/', '/tests/unit/', '')
    let test_file = substitute(test_file, '.php$', 'Test.php', '')

    return test_file
endfun
nnoremap <Leader>to :Create test<CR>
" }}}

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
    \ 'composer.json&src/&tests/': {
        \ 'src/*.php': {
            \ 'type': 'src',
            \ 'alternate': [
                \ 'tests/{}Test.php',
            \ ],
        \ },
        \ 'tests/*Test.php': {
            \ 'type': 'test',
            \ 'alternate': 'src/{}.php',
        \ },
    \ },
    \ 'composer.json&src/&tests/unit/': {
        \ 'src/*.php': {
            \ 'type': 'src',
            \ 'alternate': [
                \ 'tests/unit/{}Test.php',
            \ ],
        \ },
        \ 'tests/unit/*Test.php': {
            \ 'type': 'test',
            \ 'alternate': 'src/{}.php',
        \ },
    \ },
    \ 'composer.json&src/&spec/': {
        \ 'src/*.php': {
            \ 'type': 'src',
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
            \ 'alternate': [
                \ 'specs/{}.spec.php',
            \ ],
        \ },
        \ 'specs/*.spec.php': {
            \ 'type': 'test',
            \ 'alternate': 'src/{}.php',
        \ },
    \ },
    \ 'config/bundles.php': {
        \ 'src/Command/*Command.php': {
            \ 'type': 'command',
        \ },
        \ 'src/Controller/*Controller.php': {
            \ 'type': 'controller',
        \ },
        \ 'src/Entity/*.php': {
            \ 'type': 'entity',
            \ 'alternate': [
                \ 'src/Repository/{}Repository.php',
                \ 'src/Form/{}Type.php'
            \ ],
        \ },
        \ 'src/EventSubscriber/*Subscriber.php': {
            \ 'type': 'subscriber',
        \ },
        \ 'src/Form/*Type.php': {
            \ 'type': 'form',
            \ 'alternate': 'src/Entity/{}.php',
        \ },
        \ 'src/Repository/*Repository.php': {
            \ 'type': 'repository',
            \ 'alternate': 'src/Entity/{}.php',
        \ },
        \ 'templates/*.html.twig': {
            \ 'type': 'template',
        \ },
        \ 'config/packages/*.yaml': {
            \ 'type': 'config',
        \ },
        \ 'config/services.yaml': {
            \ 'type': 'service',
        \ },
        \ 'var/log/*.log': {
            \ 'type': 'log',
        \ },
    \ },
\ }

au FileType php setlocal keywordprg=psysh-doc

" PHP {{{
" Phpactor
au FileType php setlocal omnifunc=phpactor#Complete
au FileType php nnoremap gd :call phpactor#GotoDefinition()<CR>
au FileType php nnoremap <Leader>m :call phpactor#ContextMenu()<CR>
au FileType php nnoremap <Leader>ua :call phpactor#UseAdd() <bar> :call PhpSortUse()<CR>
au FileType php nnoremap <Leader>us :call PhpSortUse()<CR>

" PHP folding
let php_folding=0

" PHP Complete
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" PHPDoc
let g:pdv_template_dir = $HOME."/.vim/pdv_templates_snip"
au FileType php nnoremap <Leader>d :call pdv#DocumentWithSnip()<CR>

" Advanced highlighting
function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction
augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END
" }}}
"
" vim: foldmethod=marker
