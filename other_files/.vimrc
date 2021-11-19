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
noremap i <Up>
noremap j <Left>
noremap k <Down>
noremap l <Right>
noremap <space><space> <Insert>
noremap ; $
noremap h 0
noremap u b
noremap o w
noremap t v 
noremap <C-t> <C-v>
noremap <C-s> /
noremap! <kHome> <Esc>
inoremap <kHome> <Esc>
vnoremap <kHome> <Esc>
" this is need for some reason ...
map e <nop>
nnoremap e db 
nnoremap r dw
noremap s o<Esc>
nnoremap S O<Esc>

" Undo Redo
noremap <C-e> <undo>
noremap <space>u :bd<cr>

" Commands
nnoremap <Tab> :bnext<cr>
nnoremap <space>f :Lexplore<cr>
nnoremap <space>; :w<cr>
" Open Explore in the directory of current file
nnoremap <space>m :Lexplore %:p:h<CR>
noremap <silent> <space>b :ls<CR>:b<Space>
noremap <C-c>f :browse oldfiles<CR>

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

" Completion
" C-x C-n
