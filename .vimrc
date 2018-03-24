" Plugins {{{ " Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Common
Plugin 'PeterRincker/vim-argumentative'
Plugin 'Raimondi/delimitMate'
Plugin 'VundleVim/Vundle.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'bling/vim-airline'
Plugin 'duggiefresh/vim-easydir'
Plugin 'easymotion/vim-easymotion'
Plugin 'janko-m/vim-test'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'junegunn/vim-easy-align'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'scrooloose/nerdtree'
Plugin 'sgur/vim-editorconfig'
Plugin 'tpope/vim-surround'
Plugin 'vim-syntastic/syntastic'
Plugin 'voronkovich/file-magic.vim'
Plugin 'wincent/ferret'
Plugin 'xolox/vim-misc'
Plugin 'ryanoasis/vim-devicons'

" CtrlP
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fisadev/vim-ctrlp-cmdpalette'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'nixprime/cpsm'
Plugin 'tacahiroy/ctrlp-funky'

" Colorschemes
" Plugin 'xolox/vim-colorscheme-switcher'
Plugin 'flazz/vim-colorschemes'

" Comments
Plugin 'tpope/vim-commentary'

" Code completion
Plugin 'Valloric/YouCompleteMe'

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'sniphpets/sniphpets'
Plugin 'sniphpets/sniphpets-common'
Plugin 'sniphpets/sniphpets-doctrine'
Plugin 'sniphpets/sniphpets-phpunit'
Plugin 'sniphpets/sniphpets-peridot'
Plugin 'sniphpets/sniphpets-postfix-codes'
Plugin 'sniphpets/sniphpets-sylius'
Plugin 'sniphpets/sniphpets-symfony'

" PHP
" Conficts with YCM
" Plugin 'arnaud-lb/vim-php-namespace'
" Plugin 'docteurklein/vim-symfony'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'StanAngeloff/php.vim'
Plugin 'adoy/vim-php-refactoring-toolbox'
Plugin 'dantleech/vim-phpnamespace'
Plugin 'evidens/vim-twig'
Plugin 'noahfrederick/vim-composer'
Plugin 'php-vim/phpcd.vim'
" Plugin 'phpactor/phpactor'
Plugin 'rayburgemeestre/phpfolding.vim'
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'
Plugin 'voronkovich/ctrlp-symfony2.vim'
Plugin 'voronkovich/php-getter-setter.vim'
Plugin 'voronkovich/vim-composer-open-class-file'

" JS
Plugin 'pangloss/vim-javascript'

" Html
Plugin 'Valloric/MatchTagAlways'
Plugin 'mattn/emmet-vim'

" ZSH highlighting
Plugin 'clones/vim-zsh'

call vundle#end()
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

nnoremap <C-z> <Nop>

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
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

" Write file with root permissions
command! W w !sudo tee %

" Working with buffers {{{2
nmap <Space>l :CtrlPBuffer<CR>
nmap <Leader>q :bd<CR>
nmap <C-h> <C-^> " Toggle between two buffers
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

" Ferret
nnoremap <Leader>a :Ack 

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

" CtrlP command palette
nnoremap <Space>; :CtrlPCmdPalette<CR>

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
    let test_file = substitute(expand('%:p'), '/src/', '/tests/', '')
    let test_file = substitute(test_file, '.php$', 'Test.php', '')

    return test_file
endfun
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
" let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
let g:cpsm_highlight_mode = 'detailed'
nnoremap <Space><BS> :CtrlPNerdTree<CR>
nnoremap <Space>/ :CtrlPLine<CR>
nnoremap <CR>   :CtrlP<CR>
nnoremap <C-z>t :CtrlP tests/<CR>
nnoremap <C-z>m :CtrlPSymfonyEntities<CR>
nnoremap <C-z>c :CtrlPSymfonyControllers<CR>
nnoremap <C-z>v :CtrlPSymfonyViews<CR>
nnoremap <C-z>a :CtrlPSymfonyAssets<CR>
nnoremap <C-z>o :CtrlPSymfonyConfigs<CR>
nnoremap <C-z>f :CtrlPSymfonyForms<CR>
nnoremap <C-z>l :CtrlPSymfonyListeners<CR>
nnoremap <C-z>d :CtrlPSymfonyServices<CR>
nnoremap <Leader>f :CtrlPFunky<CR>
" }}}

" Easy motion
let g:EasyMotion_leader_key = '<Space>'

" Synastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers = ['php']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
" }}}

" Easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" PHP {{{
au FileType php nnoremap gf :call composer#open_file#open(expand('<cword>'))<CR>

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

" PHP getset plugin
let g:phpgetset_getterTemplate =
            \ "    \n" .
            \ "    public function %funcname%()\n" .
            \ "    {\n" .
            \ "        return $this->%varname%;\n" .
            \ "    }"
let g:phpgetset_setterTemplate =
            \ "    \n" .
            \ "    public function %funcname%($%varname%)\n" .
            \ "    {\n" .
            \ "        $this->%varname% = $%varname%;\n\n" .
            \ "        return $this;\n" .
            \ "    }"

" PHP namespace
inoremap <Leader>pu <C-O>:call PhpInsertUse()<CR>
noremap <Leader>pu :call PhpInsertUse()<CR>
inoremap <Leader>pe <C-O>:call PhpExpandClass()<CR>
noremap <Leader>pe :call PhpExpandClass()<CR>
inoremap <silent><leader>pn :call PhpNamespaceInsert()<CR>
noremap <silent><leader>pn :call PhpNamespaceInsert()<CR>

" Sniphpets
" Override a default namespace resolving function
" fun! sniphpets#namespace()
"     " See https://github.com/dantleech/vim-phpnamespace
"     return PhpNamespaceGet()
" endf

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
