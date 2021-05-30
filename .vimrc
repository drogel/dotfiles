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

" Use 4 spaces when expanding tabs.
set sts=4

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Highlights matching phrases when searching.
set hlsearch

" Sets incremental search: highlights the pattern being searched while typing.
set incsearch

" Avoid vim warnings when switching or quitting unsaved buffers.
set hidden

" Adds a colored column on the column 80, to provide a visual guide on how
" long lines of code should be. I try not to write lines longer than 80
" columns, because that usually means I have too many nested code blocks or
" complex logic that should be split in parts.
set colorcolumn=80

" Adds an extra column to the left of the viewport to show LSP or Git
" integration information.
set signcolumn=yes

" Adds some lines to offset the viewport when scrolling near the edges of the
" screen.
set scrolloff=12

" Sources project-wise .vimrc files when running `$ vim .` on a directory.
set exrc

" Mutes sounds when errors occur in vim.
set noerrorbells

" ======= General mappings =======
"
"

" Sets Space to Leader.
let mapleader=" "

" Tapping j twice exits insert mode.
imap jj <Esc>

" Enter terminal mode.
nnoremap <leader>t :term<CR>

" Write on the current buffer.
nnoremap <leader>W :w<CR>

" Delete/close the current buffer.
nnoremap <leader>x :bd<CR>

" Append a new char and immediately return to normal mode.
nnoremap \ a_<Esc>r

" Insert a new char and immediately return to normal mode.
nnoremap <bar> i_<Esc>r

" Yanks the rest of the line, starting from the cursor.
nmap Y y$

" Tapping enter on normal mode turns off all highlights.
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

" Insert from the next parenthesis, bracket or brace.
nnoremap <Leader>g %i

" Go to the next comma and append a new line after it.
nnoremap <Leader>, f,a<Enter><Esc>

" Find next parenthesis and change inside/around parentheses.
nnoremap <Leader>( f(ci(
nnoremap <Leader>) f)ca)

" Find next bracket and change inside/around brackets.
nnoremap <Leader>[ f[ci[
nnoremap <Leader>] f]ca]

" Find next brace and change inside/around braces.
nnoremap <Leader>{ f{ci{
nnoremap <Leader>} f}ca}

" Jump to the next found { character, move inside the block it defines, unfold
" the block and center the viewport.
nnoremap <Leader>z /\{<CR>lzozz

" It is easier for me to press <Space>w to go to the end of the line.
nnoremap <Leader>w $

" It is easier for me to press <Space>b to go to the beginning of the line.
nnoremap <Leader>b ^

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

" Appends from the next found parenthesis, brace or square brace.
nnoremap <Leader>G /[\(\{\[]<CR>a

" ======= Swift-specific mappings =======
"
"

" Swift strong self.
nnoremap <Leader>I oguard let self = self else { return }<Esc>

" Inserts a swift // MARK: - comment.
nnoremap <Leader>m o// MARK: -<Esc>a_<Esc>r<Space>a

