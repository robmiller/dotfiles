" Bye, vi
set nocompatible
syntax on
set encoding=utf-8
" Comma is an easier leader key to hit
let mapleader = ","
let maplocalleader = ","

set clipboard=unnamed

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
    \ setlocal expandtab |
    \ setlocal smarttab
let b:ruby_no_expensive = 1

autocmd FileType gitcommit set colorcolumn=72 spell

autocmd FileType markdown setlocal spell spelllang=en_gb

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

" Ctrl-P config
" comma-r to activate most recently used files mode
nnoremap <leader>r :CtrlPMRUFiles<CR>
" enable ctrlp-funky extension
let g:ctrp_extensions = ['funky']
" comma-f to activate the function list
nnoremap <leader>f :CtrlPFunky<CR>
" comma-F to active the function list using the word under the cursor
nnoremap <leader>F :execute 'CtrlPFunky '.expand('<cword>')<CR>

" dwm config
let g:dwm_master_pane_width = 130

" airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1

" Autocomplete settings
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" Cmd-Shift-R for RSpec
nmap <silent> <D-R> :call RunRspecCurrentFileConque()<CR>
" Cmd-Shift-L for RSpec Current Line
nmap <silent> <D-L> :call RunRspecCurrentLineConque()<CR>
" ,Cmd-R for Last conque command
nmap <silent> ,<D-R> :call RunLastConqueCommand()<CR>

:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

nnoremap <silent> <C-s> :call RelatedSpecVOpen()<CR>
nnoremap <silent> ,<C-s> :call RelatedSpecOpen()<CR>

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
nnoremap <leader>v `[v`]
" comma-=: align assignments in current block
nnoremap <leader>= :Tab /=<CR>
" comma-[: put array element on a new line
nnoremap <leader>[ f,a<CR><ESC>
" comma-t: toggle TagBar, a plugin that displays ctags in a sidebar
nnoremap <leader>t :TagbarToggle<CR>
" Select just-pasted text
nnoremap gp `[v`]
" Set paste, paste, set nopaste
nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
" Word count current file
nnoremap <Leader>c :!wc -w '%'<CR>

" Leader commands for blogging
function LiquidLeaders()
	" Highlight blocks in Liquid
	nnoremap <Leader>h i{% highlight ruby %}<ESC>o<ESC>o{% endhighlight %}<ESC>k
	nnoremap <Leader>s o__________<ESC>o<ESC>
endfunction
autocmd FileType liquid call LiquidLeaders()

" Leader commands for xmp-filter
autocmd FileType ruby nmap <buffer> <leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <leader>m <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <leader>r <Plug>(xmpfilter-run)

" Commands for quickly editing and reloading this file
nnoremap <leader>ev :sp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" comma-c: comment out the current line
augroup comment_line
    autocmd!
    autocmd FileType php,javascript nnoremap <buffer> <localleader>c I//
augroup END

augroup run_line
	autocmd!
	autocmd FileType ruby nnoremap <F5> yyp!!ruby<CR><Esc>I# => <Esc>
augroup END

" Command for reformatting JSON files
com! FormatJSON %!python -m json.tool

" Highlight 'words to avoid in tech writing'
highlight TechWordsToAvoid ctermbg=red ctermfg=white
function MatchTechWordsToAvoid()
	match TechWordsToAvoid /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\)\>/
endfunction
autocmd FileType markdown call MatchTechWordsToAvoid()
autocmd BufWinEnter *.md call MatchTechWordsToAvoid()
autocmd InsertEnter *.md call MatchTechWordsToAvoid()
autocmd InsertLeave *.md call MatchTechWordsToAvoid()
autocmd BufWinLeave *.md call clearmatches()
