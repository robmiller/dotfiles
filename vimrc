" Bye, vi
set nocompatible
syntax on
set encoding=utf-8
" Comma is an easier leader key to hit
let mapleader = ","
let maplocalleader = ","

set mouse=a
set background=dark
colorscheme solarized

" Pathogen is the nicest way to load plugins
call pathogen#infect()

" Load Powerline
if isdirectory(expand('~/.local/lib/python2.7/site-packages/powerline/bindings/vim'))
	set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim
endif
if isdirectory(expand('~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim'))
	set rtp+=~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim
endif

" Tabs are four spaces wide
set tabstop=4
" Newlines should start at the same level as the line above
set autoindent
" When indenting, indent by four spaces
set shiftwidth=4
" Always indent to a multiple of shiftwidth
set shiftround
" This is here to wrap Git commit messages to 72 chars.
filetype indent plugin on

" Display when in insert/visual/replace mode in the status bar
set showmode
" Show the number of selected characters in visual mode
set showcmd
" Allow hiding buffers that have changes
set hidden

" When changing buffers with :e, match with wildcards
set wildmenu
" Personal preference; I like the immediate visual feedback
set wildmode=list:longest

" Display a minimum of three lines above/below the cursor in the window
set scrolloff=3
" No audible bell
set visualbell
" For better redrawing, allegedly
set ttyfast

" If files are modified outside Vim, read them automatically
set autoread
" Save files when switching buffers etc.
set autowrite
set fileformats+=mac

" Exclude hidden files from the file browser
if !exists('g:netrw_list_hide')
	let g:netrw_list_hide = '^\.,\~$,^tags$'
endif

" A more sensible undofile structure, taken from Tim Pope's
" sensible.vim
let s:dir = has('win32') ? '~/Application Data/Vim' : has('mac') ? '~/Library/Vim' : '~/.local/share/vim'
if isdirectory(expand(s:dir))
  if &directory =~# '^\.,'
    let &directory = expand(s:dir) . '/swap//,' . &directory
  endif
  if &backupdir =~# '^\.,'
    let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  endif
  if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    let &undodir = expand(s:dir) . '/undo//,' . &undodir
  endif
endif
if exists('+undofile')
  set undofile
endif

" Load matchit.vim
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Underline the current line
set cursorline
" Display the cursor's location in the file in the bottom right
set ruler
" Use relative line numbers rather than absolute ones
set relativenumber

set backspace=indent,eol,start
set laststatus=2

" Make the behaviour of Y the same as C and D (i.e. yank to the end of
" the line rather than yanking the whole line).
nnoremap Y y$

" Toggle the Tagbar plugin, a sidebar with a list of ctags
nnoremap T :TagbarToggle<CR>

" Always use Perl-style regular expressions
nnoremap / /\v
vnoremap / /\v

" Display invisibles
set list
set listchars=trail:·,precedes:«,extends:»,eol:¬,tab:▸\ 

" Folding
" Start with all folds collapsed
set foldlevelstart=0
nnoremap + za
vnoremap + za

" We're using a 256 colour terminal.
set t_Co=256

" The next few settings set up a nice find-as-you-type that ignores case when
" you want to but is case-sensitive when you want it to be as well
set ignorecase
set smartcase
set incsearch
set hlsearch
" Replace all occurences on a line by default; makes s///g go back to replacing
" just the first.
set gdefault
" Highlight matching brackets
set showmatch
" Ctrl-L to clear search highlighting
nnoremap <silent> <cr> :nohlsearch<CR>
" Use tab to move through matching brackets/braces
nnoremap <tab> %
vnoremap <tab> %

" Soft-wrap text
set wrap
" Wrap at 72 chars wide
set textwidth=72
set formatoptions=qrn1

" Set .md files to Markdown syntax
au BufNewFile,BufRead *.md set filetype=markdown
" Set .twig files to HTML Jinja syntax (it's what Twig is based on)
au BufNewFile,BufRead *.twig set filetype=jinja
" Capistrano's Capfiles are just Ruby
au BufNewFile,BufRead Capfile set filetype=ruby
" Gitconfigs
au BufNewFile,BufRead *gitconfig set filetype=gitconfig

autocmd FileType ruby
	\ setlocal shiftwidth=2 |
	\ setlocal tabstop=2 |
	\ setlocal expandtab

autocmd FileType gitcommit set colorcolumn=72 spell

" Space in normal mode centres the screen on the current line
nnoremap <space> zz

" Unmap arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Unmap help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" In insert mode, double-tap J to enter command mode.
inoremap jj <ESC>

" Some mappings for tabs: Cmd + number selects a particular tab
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
" ...and Cmd + 0 selects the final tab
map <D-0> :tablast<CR>

" comma-W: strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" comma-A: start an Ack search
nnoremap <leader>a :Ack
" comma-S: sort CSS properties alphabetically
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" comma-q: hard-wrap current paragraph
nnoremap <leader>q gqip
" comma-w: hard-wrap current line as though it was a paragraph
nnoremap <leader>w o<ESC>kgqip}dd
" comma-v: select the just-pasted text
nnoremap <leader>v V`]
" comma-=: align assignments in current block
nnoremap <leader>= :Tab /=<CR>
" comma-[: put array element on a new line
nnoremap <leader>[ f,a<CR><ESC>
" comma-t: toggle TagBar, a plugin that displays ctags in a sidebar
nnoremap <leader>t :TagbarToggle<CR>
" Select just-pasted text
nnoremap gp `[v`]

" Commands for quickly editing and reloading this file
nnoremap <leader>ev :sp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" comma-c: comment out the current line
augroup comment_line
	autocmd!
	autocmd FileType php,javascript nnoremap <buffer> <localleader>c I//
augroup END

