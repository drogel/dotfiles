syntax on
filetype plugin indent on

map <Space> <Leader>

set showcmd
set showmode

set backspace=indent,eol,start

set hidden

set wildmenu
set wildmode=list:longest

set ignorecase
set smartcase

set relativenumber

set sts=4
set background=dark	

set clipboard=unnamed
set nowrap
set wrapscan


" Tapping j twice exits insert mode
imap jj <Esc>

" Press enter in normal mode to insert a new line and return to normal mode
nmap <CR> _i<Enter><Esc>

" Append a new char and inmediately return to normal mode
nnoremap \ a_<Esc>r

" Insert a new char and inmediately return to normal mode
nnoremap <bar> i_<Esc>r

" Yanks the rest of the line, starting from the cursor
nmap Y y$

" Tapping f twice searches forwards
nmap ff /

" Tapping F twice searches backwards
nmap FF ?

" Yank to the system clipboard
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y

" Paste from the system clipboard
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P

" Replace selection with contents of default register, sending selection to
" the black hole register
vnoremap <Leader>p "_dP

" Insert from the next parenthesis, bracket or squirly brace
nnoremap <Leader>g %i

" Go to the next comma and append a new line after it
nnoremap <Leader>, f,a<Enter><Esc>

" Find next parenthesis and change inside/around parentheses
nnoremap <Leader>( f(ci(
nnoremap <Leader>) f)ca)

" Find next bracket and change inside/around brackets
nnoremap <Leader>[ f[ci[
nnoremap <Leader>] f]ca]

" Find next squirly brace and change inside/around squirly braces
nnoremap <Leader>{ f{ci{
nnoremap <Leader>} f}ca}

" Move visually selected text one line up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Jump to the next found { character, move inside the block it defines, unfold
" the block and center the viewport
nnoremap <Leader>z /\{<CR>lzozz

" --- Swift specific mappings ---
"
" Swift strong self
nnoremap <Leader>I oguard let self = self else { return }<Esc>

" Inserts a swift // MARK: - comment
nnoremap <Leader>m o// MARK: -<Esc>a_<Esc>r<Space>a
