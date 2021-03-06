" Vundle related stuff starts here
set nocompatible

" Required Vundle setup
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-dispatch'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'sickill/vim-monokai'
Plugin 'jvirtanen/vim-octave'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'morhetz/gruvbox'
Plugin 'leafgarland/typescript-vim'
Plugin 'jparise/vim-graphql'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()

filetype plugin indent on
syntax enable

"Not sure what this is
"set grepformat=%f:%l:%c%m

" True color in terminal
set termguicolors

colorscheme gruvbox

if has('gui_running')
  "set background=light
  set background=dark
else
  set t_Co=256
  set background=dark
  highlight Normal ctermbg=NONE
  highlight nonText ctermbg=NONE
endif

set vb

"set guifont= Monako\ 11
if has("gui_macvim")
  "set guifont=Inconsolata:h13
  set guifont=PragmataPro:h13
  macmenu &File.New\ Tab key=<nop>
  map <D-t> <Plug>PeepOpen
endif

set guioptions-=l
set guioptions-=r
set guioptions-=T
set guioptions-=L

set noautochdir
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
set expandtab "indent with spaces
set tabstop=2 "two spaces on tab
set shiftwidth=2 "how many columns text is indented with the reindent operations (<< and >>)
set number
set ignorecase
hi Search guibg=red guifg=wheat gui=none

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

"yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" The Silver Searcher
"if executable('ag')
  " Note we extract the column as well as the file and line number
 " set grepprg=ag\ --nogroup\ --nocolor\ --column
  "set grepformat=%f:%l:%c%m
"endif
" Use cursor keys for quicklist navigation
nmap <silent> <RIGHT> :cnext<CR>
nmap <silent> <LEFT> :cprev<CR>

" ALE
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --jsx-bracket-same-line --trailing-comma'

" HASKELL-VIM
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Ag
" Configure ag.vim to always start searcing from project root
let g:ag_working_path_mode="r"

" bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Ctrlp
let g:ctrlp_working_path_mode = 'ra'

" JSX
let g:jsx_ext_required = 0

" You Complete Me
" Autocomplete on '.'
if !exists("g:ycm_semantic_triggers")
 let g:ycm_semantic_triggers = {}
 endif
 let g:ycm_semantic_triggers['typescript'] = ['.']
" Disable for now
let g:loaded_youcompleteme = 1

"map split navitagtion
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
" move current tab to left or right with Alt-Left or Alt-Right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

set backspace=2 " make backspace work like most other apps

"Syntax highlighting fixes for js files with e.g. long GraphQL query strings
autocmd FileType javascript autocmd BufEnter * :syntax sync minlines=200 "Add min line sync to improve syntax highlighting

"Use F12 to sync from start and clean up highligting problems
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

:inoremap jk <Esc>
let mapleader = "\<Space>"

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules

" Remove trailing whitespace from file
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

" Show irregular white space chars
command! SetWhitespaceListChars set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•

command! FixIrregularWhiteSpace %s/ / /g
