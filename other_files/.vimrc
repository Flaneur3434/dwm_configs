set number	"show line numbers
set wildmenu	"enable a menu that shows tab completion options in the status bar
set showmatch	"highlights matching brackets on cursor hover
set ruler	"show cursor position in status bar
set showcmd	"shows the normal mode command before it gets executed

set encoding=utf-8
set fileformats=unix,dos,mac

set hlsearch	"highlights searches
set incsearch	"incremental search (searches character by character)
set ignorecase	"ignores the case of a search
set smartcase	"only ignores case if there are no capital letters in search (only works after ignorecase has been set)

set tabstop=4		"the amount of spaces that vim will equate to a tab character
set softtabstop=4	"like tabstop, but for editing operations (insert mode)
set shiftwidth=4	"used for autoindent and << and >> operators in normal mode
set autoindent		"copies indent from current line to the next line
set expandtab		"tabs will expand to whitespace characters

set esckeys		"allows function keys to be recognized in Insert mode
set ttimeoutlen=20	"timeout for a key code mapping
set timeoutlen=1000	"time(ms) to wait for key mappings

set clipboard+=autoselect

syntax enable			"turn syntax highlighting on
colorscheme peachpuff
filetype plugin indent on	"load plugin and indent files associated a detected filetype
runtime macros/matchit.vim	"allows jumping between brackets with % in normal mode

augroup general
    autocmd!
    "keep equal proportions when windows resized
    autocmd VimResized * wincmd =
    "save cursor position in a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"")
              \ <= line("$") | exe "normal! g'\"" | endif
augroup END

augroup languages
    autocmd!
    autocmd BufNewFile,BufRead *.bash set syntax=sh
    autocmd FileType python xnoremap <leader>r <esc>:'<,'>:w !python3<CR>
    autocmd FileType go set noexpandtab
    autocmd FileType html :syntax sync fromstart
    autocmd FileType html,javascript,css,json,yaml,sh
                \ setlocal ts=2 sts=2 sw=2 expandtab
augroup END

":map       Normal, Visual and Operator-pending
":vmap      Visual
":nmap      Normal
":omap      Operator-pending (Eg: dw where d is operator character and w is motion character)
":map!      Insert and Command-line
":imap      Insert
":cmap      Command-line
"nnoremap, xnoremap, cnoremap, inoremap, etc. prevent mapping recursively

" Basic Movement
nnoremap i <Up>
nnoremap j <Left>
nnoremap k <Down>
nnoremap l <Right>
vnoremap i <Up>
vnoremap j <Left>
vnoremap k <Down>
vnoremap l <Right>

nnoremap <space><space> <Insert>

noremap ; $
noremap h 0

noremap u b
noremap o w
noremap e db
noremap r dw

noremap t v
noremap <C-t> <C-v>

noremap s o<Esc>
noremap S O<Esc>

noremap! <kHome> <Esc>
inoremap <kHome> <Esc>
vnoremap <kHome> <Esc>

noremap <C-s> /

" Undo Redo
noremap <C-e> <undo>
noremap <space>u :bd<cr>

" Commands
nnoremap <Tab> :bnext<CR> " move to next buffer
nnoremap <space>; :wa<CR>
nnoremap <space>m :Lexplore %:p:h<CR> " Open Explore in the directory of current file
noremap <silent> <space>f :ls<CR>:b<Space> " Open buffer list and select a number
noremap <C-c>f :browse oldfiles<CR> " Open a recent file list and select a file
noremap <C-c>q :q!<CR>
noremap <f3> :nohl<CR>

" Copy and Paste
xnoremap <C-c> "+y
nnoremap <C-x> "+p

" Window Commands
noremap ws :split<cr>
noremap wv :vsplit<cr>
noremap wc :close<cr>
noremap wo :only<cr>

noremap wj <C-w>h
noremap wl <C-w>l
noremap wi <C-w>k
noremap wk <C-w>j

" CTAGS
set tags=./tags;/
nnoremap <space>g <C-]>
nnoremap <space>h <C-t>

" Explore https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
" Keep the current directory and the browsing directory synced.
let g:netrw_keepdir = 0
" Hide the banner
" let g:netrw_banner = 0
" Change copy command
let g:netrw_localcopydircmd = 'cp -r'
" Highlight marked files
hi! link netrwMarkFile Search
function! NetrwMapping()
endfunction

" make function run automatically when netrw file type is opened
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <buffer> i <Up>
  nnoremap <buffer> j <Left>
  nnoremap <buffer> k <Down>
  nnoremap <buffer> l <Right>
  nnoremap <buffer> ^ -^ 
  " file management
  nnoremap <silent> <buffer> c :!touch untitled.txt<CR> 
  nnoremap <silent> <buffer> <space>m :bd<CR>
endfunction

" Completion
" C-x C-n

" Pluggin
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/jceb/vim-orgmode'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-surround'
call plug#end()

" --- vim-commentary ---
" gcc - comments out a line
" gcap - comments out a paragraph
" gc (in visual mode) - comment out the selection

" --- vim-surround ---
" cs"' - change "hello world" -> 'hello world'
" yss" - change hello world -> "hello world"
" ysiw) (with cursor on hello) - change hello world -> (hello) world
" ds" - change "hello world" -> hello world

