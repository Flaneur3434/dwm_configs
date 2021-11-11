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
" Open Explore in the directory of current file
nnoremap <space>m :Lexplore %:p:h<CR>

"=== VIM BUFFER LIST SCRIPT 1.3 ================================================
"= OPTIONAL:                                                                   =
"=     let g:BufferListWidth = 25                                              =
"=     let g:BufferListMaxWidth = 50                                           =
"=     hi BufferSelected term=reverse ctermfg=white ctermbg=red cterm=bold     =
"=     hi BufferNormal term=NONE ctermfg=black ctermbg=darkcyan cterm=NONE     =
"===============================================================================

if exists('g:BufferListLoaded')
  finish
endif
let g:BufferListLoaded = 1

if !exists('g:BufferListWidth')
  let g:BufferListWidth = 20
endif

if !exists('g:BufferListMaxWidth')
  let g:BufferListMaxWidth = 40
endif

" toggled the buffer list on/off
function! BufferList()
  " if we get called and the list is open --> close it
  if bufexists(bufnr("__BUFFERLIST__"))
    exec ':' . bufnr("__BUFFERLIST__") . 'bwipeout'
    return
  endif

  let l:bufcount = bufnr('$')
  let l:displayedbufs = 0
  let l:activebuf = bufnr('')
  let l:activebufline = 0
  let l:buflist = ''
  let l:bufnumbers = ''
  let l:width = g:BufferListWidth

  " iterate through the buffers
  let l:i = 0 | while l:i <= l:bufcount | let l:i = l:i + 1
    let l:bufname = bufname(l:i)
    if strlen(l:bufname)
      \&& getbufvar(l:i, '&modifiable')
      \&& getbufvar(l:i, '&buflisted')

      " adapt width and/or buffer name
      if l:width < (strlen(l:bufname) + 5)
        if strlen(l:bufname) + 5 < g:BufferListMaxWidth
          let l:width = strlen(l:bufname) + 5
        else
          let l:width = g:BufferListMaxWidth
          let l:bufname = '...' . strpart(l:bufname, strlen(l:bufname) - g:BufferListMaxWidth + 8)
        endif
      endif

      if bufwinnr(l:i) != -1
        let l:bufname = l:bufname . '*'
      endif
      if getbufvar(l:i, '&modified')
        let l:bufname = l:bufname . '+'
      endif
      " count displayed buffers
      let l:displayedbufs = l:displayedbufs + 1
      " remember buffer numbers
      let l:bufnumbers = l:bufnumbers . l:i . ':'
      " remember the buffer that was active BEFORE showing the list
      if l:activebuf == l:i
        let l:activebufline = l:displayedbufs
      endif
      " fill the name with spaces --> gives a nice selection bar
      " use MAX width here, because the width may change inside of this 'for' loop
      while strlen(l:bufname) < g:BufferListMaxWidth
        let l:bufname = l:bufname . ' '
      endwhile
      " add the name to the list
      let l:buflist = l:buflist . '  ' .l:bufname . "\n"
    endif
  endwhile

  " generate a variable to fill the buffer afterwards
  " (we need this for "full window" color :)
  let l:fill = "\n"
  let l:i = 0 | while l:i < l:width | let l:i = l:i + 1
    let l:fill = ' ' . l:fill
  endwhile
  
  " now, create the buffer & set it up
  exec 'silent! ' . l:width . 'vne __BUFFERLIST__'
  setlocal noshowcmd
  setlocal noswapfile
  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal nobuflisted
  setlocal nomodifiable
  setlocal nowrap
  setlocal nonumber

  " set up syntax highlighting
  if has("syntax")
    syn clear
    syn match BufferNormal /  .*/
    syn match BufferSelected /> .*/hs=s+1
    hi def BufferNormal ctermfg=black ctermbg=white
    hi def BufferSelected ctermfg=white ctermbg=black
  endif

  setlocal modifiable
  if l:displayedbufs > 0
    " input the buffer list, delete the trailing newline, & fill with blank lines
    put! =l:buflist
    " is there any way to NOT delete into a register? bummer...
    "norm Gdd$
    norm GkJ
    while winheight(0) > line(".")
      put =l:fill
    endwhile
  else
    let l:i = 0 | while l:i < winheight(0) | let l:i = l:i + 1
      put! =l:fill
    endwhile
    norm 0
  endif
  setlocal nomodifiable

  " set up the keymap
  noremap <silent> <buffer> <CR> :call LoadBuffer()<CR>
  noremap <silent> <buffer> q :bwipeout<CR> 
  noremap <silent> <buffer> k :call BufferListMove("down")<CR>
  noremap <silent> <buffer> i :call BufferListMove("up")<CR>
  noremap <silent> <buffer> d :call BufferListDeleteBuffer()<CR>
  noremap <silent> <buffer> <Down> k 
  noremap <silent> <buffer> <Up> i 
  noremap <buffer> h <Nop>
  noremap <buffer> l <Nop>
  noremap <buffer> <Left> <Nop>
  noremap <buffer> <Right> <Nop>
  noremap <buffer> a <Nop>
  noremap <buffer> I <Nop>
  noremap <buffer> A <Nop>
  noremap <buffer> o <Nop>
  noremap <buffer> O <Nop>
  noremap <silent> <buffer> h :call BufferListMove(1)<CR>
  noremap <silent> <buffer> ; :call BufferListMove(line("$"))<CR>

  " make the buffer count & the buffer numbers available
  " for our other functions
  let b:bufnumbers = l:bufnumbers
  let b:bufcount = l:displayedbufs

  " go to the correct line
  call BufferListMove(l:activebufline)
endfunction

" move the selection bar of the list:
" where can be "up"/"down"/"mouse" or
" a line number
function! BufferListMove(where)
  if b:bufcount < 1
    return
  endif
  let l:newpos = 0
  if !exists('b:lastline')
    let b:lastline = 0
  endif
  setlocal modifiable

  " the mouse was pressed: remember which line
  " and go back to the original location for now
  if a:where == "mouse"
    let l:newpos = line(".")
    call BufferListGoto(b:lastline)
  endif

  " exchange the first char (>) with a space
  call setline(line("."), " ".strpart(getline(line(".")), 1))

  " go where the user want's us to go
  if a:where == "up"
    call BufferListGoto(line(".")-1)
  elseif a:where == "down"
    call BufferListGoto(line(".")+1)
  elseif a:where == "mouse"
    call BufferListGoto(l:newpos)
  else
    call BufferListGoto(a:where)
  endif

  " and mark this line with a >
  call setline(line("."), ">".strpart(getline(line(".")), 1))

  " remember this line, in case the mouse is clicked
  " (which automatically moves the cursor there)
  let b:lastline = line(".")

  setlocal nomodifiable
endfunction

" tries to set the cursor to a line of the buffer list
function! BufferListGoto(line)
  if b:bufcount < 1 | return | endif
  if a:line < 1
    call cursor(1, 1)
  elseif a:line > b:bufcount
    call cursor(b:bufcount, 1)
  else
    call cursor(a:line, 1)
  endif
endfunction

" loads the selected buffer
function! LoadBuffer()
  " get the selected buffer
  let l:str = BufferListGetSelectedBuffer()
  " kill the buffer list
  bwipeout
  " ...and switch to the buffer number
  exec ":b " . l:str
endfunction

" deletes the selected buffer
function! BufferListDeleteBuffer()
  " get the selected buffer
  let l:str = BufferListGetSelectedBuffer()
  " kill the buffer list
  bwipeout
  " delete the selected buffer
  exec ":bdelete " . l:str
  " and reopen the list
  call BufferList()
endfunction

function! BufferListGetSelectedBuffer()
  " this is our string containing the buffer numbers in
  " the order of the list (separated by ':')
  let l:str = b:bufnumbers

  " remove all numbers BEFORE the one we want
  let l:i = 1 | while l:i < line(".") | let l:i = l:i + 1
    let l:str = strpart(l:str, stridx(l:str, ':') + 1)
  endwhile

  " and everything AFTER
  let l:str = strpart(l:str, 0, stridx(l:str, ':'))

  return l:str
endfunction

map <silent> <space> :call BufferList()<CR>
