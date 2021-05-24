" ======= General settings =======
"
"

" Allow backspacing over everything in insert mode (including automatically
" inserted indentation, line breaks and start of insert).
set backspace=indent,eol,start

" Command-line completion operates in an enhanced mode.  On pressing
" 'wildchar' (usually <Tab>) to invoke completion, the possible matches are
" shown just above the command line, with the first match highlighted
" (overwriting the status line, if there is one).
set wildmenu
set wildmode=list:longest

" When searching for a pattern, the case of normal letters is ignored.
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case
" characters.  Only used when the search pattern is typed and 'ignorecase'
" option is on.
set smartcase

" Use 4 spaces when expanding tabs
set sts=4

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=350

" Highlights matching phrases when searching.
set hlsearch

" Sets incremental search: higlights the pattern being searched while typing.
set incsearch

" Avoid vim warnings when switching or quitting unsaved buffers.
set hidden

" ======= General mappings =======
"
"

" Sets Space to Leader.
let mapleader=" "

" Tapping j twice exits insert mode.
imap jj <Esc>

" Append a new char and inmediately return to normal mode.
nnoremap \ a_<Esc>r

" Insert a new char and inmediately return to normal mode.
nnoremap <bar> i_<Esc>r

" Yanks the rest of the line, starting from the cursor.
nmap Y y$

" Tapping enter on normal mode turns off all higlights.
nnoremap <CR> :noh<return><esc>

" Yank to the system clipboard.
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y

" Paste from the system clipboard.
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P

" Replace selection with contents of default register, sending selection to
" the black hole register.
vnoremap <Leader>p "_dP

" Insert from the next parenthesis, bracket or squirly brace.
nnoremap <Leader>g %i

" Go to the next comma and append a new line after it.
nnoremap <Leader>, f,a<Enter><Esc>

" Find next parenthesis and change inside/around parentheses.
nnoremap <Leader>( f(ci(
nnoremap <Leader>) f)ca)

" Find next bracket and change inside/around brackets.
nnoremap <Leader>[ f[ci[
nnoremap <Leader>] f]ca]

" Find next squirly brace and change inside/around squirly braces.
nnoremap <Leader>{ f{ci{
nnoremap <Leader>} f}ca}

" Search git conflict markers.
nnoremap ]n /\v[<>=]{7}<CR>
nnoremap [n ?\v[<>=]{7}<CR>

" Delete to git conflict markers.
nnoremap d]n d/\v[<>=]{7}<CR>
nnoremap d[n d?\v[<>=]{7}<CR>

" Change to git conflict markers.
nnoremap c]n c/\v[<>=]{7}<CR>
nnoremap c[n c?\v[<>=]{7}<CR>

" Jump to next or previous buffer.
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>

" Move visually selected text one line up or down.
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Jump to the next found { character, move inside the block it defines, unfold
" the block and center the viewport.
nnoremap <Leader>z /\{<CR>lzozz

" It is easier for me to press <Space>w to go to the end of the line.
nnoremap <Leader>w $

" It is easier for me to press <Space>b to go to the beginning of the line.
nnoremap <Leader>b ^

" Adds lines above or below current cursor without moving it.
nnoremap <silent> ]<CR> :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> [<CR> :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Moves to the next uppercase letter, this way it is easy to move through
" camelCase words.
nnoremap <Leader>u /[A-Z]<CR>
nnoremap <Leader>U ?[A-Z]<CR>

" Changes to the next uppercase letter, this way it is easy to change through
" camelCase words.
nnoremap <Leader>cu c/\v[A-Z]<CR>
nnoremap <Leader>cU c?\v[A-Z]<CR>

" Deletes to the next uppercase letter, this way it is easy to delete through
" camelCase words.
nnoremap <Leader>du d/\v[A-Z]<CR>
nnoremap <Leader>dU d?\v[A-Z]<CR>

" Appends from the next found parenthesis, squirly brance or square brace.
nnoremap <Leader>G /[\(\{\[]<CR>a

" ======= Swift-specific mappings =======
"
"

" Swift strong self.
nnoremap <Leader>I oguard let self = self else { return }<Esc>

" Inserts a swift // MARK: - comment.
nnoremap <Leader>m o// MARK: -<Esc>a_<Esc>r<Space>a

