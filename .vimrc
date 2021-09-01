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
set tabstop=4
set sts=4
set shiftwidth=4

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

" Tells vim which shell to start when using `:term`. Invoking bash with -l
" (--login), makes bash read my ~/.profile at startup (among other files) and
" thus everything sourced from there.
set shell=bash\ -l

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

" Jumps to the next occurrence, centers the viewport, and opens just enough
" folds to make the line in which the cursor is located not folded.
nnoremap n nzzzv
nnoremap N Nzzzv

" Moves the line where the cursor is one line above and below.
nnoremap <Leader>k :m .-2<CR>==
nnoremap <Leader>j :m .+1<CR>==

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
" camelCase words. It does this without highlighting the search.
nnoremap <Leader>u /[A-Z]<CR>:noh<CR>
nnoremap <Leader>U ?[A-Z]<CR>:noh<CR>

" Changes to the next uppercase letter, this way it is easy to change through
" camelCase words.
nnoremap <Leader>cu c/\v[A-Z]<CR>:noh<CR>
nnoremap <Leader>cU c?\v[A-Z]<CR>:noh<CR>

" Deletes to the next uppercase letter, this way it is easy to delete through
" camelCase words.
nnoremap <Leader>du d/\v[A-Z]<CR>:noh<CR>
nnoremap <Leader>dU d?\v[A-Z]<CR>:noh<CR>

" Appends from the next found parenthesis, brace or square brace.
nnoremap <Leader>G /[\(\{\[]<CR>a

" When in terminal mode, this mapping goes to terminal-normal mode.
tnoremap <Esc> <C-\><C-n>

" In order to still be able to use <Esc> on terminal mode, I have to assign it
" to some other keystroke.
tnoremap <M-[> <Esc>

" Allows to paste text while in terminal-normal mode by just typing p, as if
" we were in vim's normal mode.
" Vim doesn't update from job when in Terminal-Normal, so we won't see our
" paste until we enter terminal-Job to see our pasted text.
function! s:SendRegisterToTerm()
	call term_sendkeys('', getreg(v:register))
endf

augroup paste_terminal_normal
	au!
	au TerminalWinOpen * nnoremap <buffer> p :<C-u>call <sid>SendRegisterToTerm()<CR>
augroup END

" ======= Swift-specific mappings =======
"
"

" Swift strong self.
nnoremap <Leader>I oguard let self = self else { return }<Esc>

" Inserts a swift // MARK: - comment.
nnoremap <Leader>m o// MARK: -<Esc>a_<Esc>r<Space>a

