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

" On Mac OS X and Windows, the * and + registers both point to the system
" clipboard so with this, the unnamed register is synchronized with the system
" clipboard.
set clipboard=unnamed

" ======= General mappings =======
"
"

" Sets Space to Leader.
map <Space> <Leader>

" Tapping j twice exits insert mode.
imap jj <Esc>

" Press enter in normal mode to insert a new line and return to normal mode.
nmap <CR> _i<Enter><Esc>

" Append a new char and inmediately return to normal mode.
nnoremap \ a_<Esc>r

" Insert a new char and inmediately return to normal mode.
nnoremap <bar> i_<Esc>r

" Yanks the rest of the line, starting from the cursor.
nmap Y y$

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

" ======= Swift-specific mappings =======
"
"

" Swift strong self.
nnoremap <Leader>I oguard let self = self else { return }<Esc>

" Inserts a swift // MARK: - comment.
nnoremap <Leader>m o// MARK: -<Esc>a_<Esc>r<Space>a

