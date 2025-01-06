" Bye, vi
set nocompatible
syntax on
filetype plugin indent on
set encoding=utf-8
" Comma is an easier leader key to hit
let mapleader = ","
let maplocalleader = ","

" Use the system clipboard
set clipboard=unnamed

set mouse=a
set background=light
colorscheme solarized

" We're using a 256 colour terminal.
set t_Co=256

" Pathogen is the nicest way to load plugins
call pathogen#infect()

" Tabs are two spaces wide
set tabstop=2
" When indenting, indent by two spaces
set shiftwidth=2
" Tabs are spaces
set expandtab
" Newlines should start at the same level as the line above
set autoindent
" Always indent to a multiple of shiftwidth
set shiftround

" Commands for converting tabs to spaces.
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" Soft-wrap text
set wrap
" Wrap at 72 chars wide
set textwidth=72
set formatoptions=qrn1
" When wrapping text, don't put a double space after sentences
set nojoinspaces

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

" In insert mode, double-tap K to enter command mode.
inoremap kk <ESC>

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

" Shorter shortcuts for moving between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" The minimum width of the active window
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

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

" A mapping for command-line mode to replace %% with the directory of
" the current file; a useful parallel to %. Credit to Gary Bernhardt
cnoremap %% <C-R>=expand('%:h').'/'<cr>

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
" Always show a status line, even if there's only one window
set laststatus=2

" Make the behaviour of Y the same as C and D (i.e. yank to the end of
" the line rather than yanking the whole line).
nnoremap Y y$

" Display invisibles
set list
set listchars=trail:·,precedes:«,extends:»,eol:¬,tab:▸\ 

" Always use Perl-style regular expressions when searching
nnoremap / /\v
vnoremap / /\v
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

" Lint files with Syntastic on read, not just write
let g:syntastic_check_on_open = 1

" Filetype-specific stuff

" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
autocmd FileType markdown setlocal spell spelllang=en_gb
let g:syntastic_markdown_checkers = ['proselint']

" Replace unspaced em dashes (American) or spaced hypens (yeuch) with spaced en dashes in the current line
nnoremap <leader>– :s/\v(\s*-\s*\|\s*—\s*)/ – /g<CR>
" Switch double quotes to single ones
nnoremap <leader>“ :s/.*/\=tr(submatch(0), '“”', '‘’')<CR>:nohlsearch<CR>
" Format a paragraph as a Markdown quote
nnoremap <leader>> vipJI> “<ESC>gqip

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

let g:PHP_outdentphpescape = 0
let g:PHP_vintage_case_default_indent = 1

autocmd FileType vcl,liquid,pml,markdown,css,scss,sass
    \ setlocal shiftwidth=2 |
    \ setlocal tabstop=2 |
    \ setlocal expandtab |
	\ setlocal smarttab |
	\ setlocal colorcolumn=72

autocmd FileType php,vue,javascript,blade
	\ setlocal shiftwidth=2 |
	\ setlocal tabstop=2 |
	\ setlocal expandtab |
	\ setlocal smarttab

" Plugin-specific stuff

" Smart quotes
augroup textobj_quote
  autocmd!
  autocmd FileType markdown call textobj#quote#init()
  autocmd FileType pml      call textobj#quote#init()
  autocmd FileType text     call textobj#quote#init({'educate': 0})
augroup END

" Ctrl-P config
" comma-r to activate most recently used files mode
nnoremap <leader>u :CtrlPMRUFiles<CR>
" enable ctrlp-funky extension
let g:ctrp_extensions = ['funky']
" comma-f to activate the function list
nnoremap <leader>f :CtrlPFunky<CR>
" comma-F to active the function list using the word under the cursor
nnoremap <leader>F :execute 'CtrlPFunky '.expand('<cword>')<CR>
" Ignore files in CtrlP's finder
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|vendor\|_site'

" When highlighting a result in CtrlP, hit ctrl-v to insert the filename
" at the cursor point. If it's a Jekyll post, it'll be inserted without
" its extension, because you're probably using it in {% post_url %}
function! YankFilenameFunc(action, line)
  if a:action =~ '^[v]$' && fnamemodify(a:line, ':h') == '_posts'
    " Get the filename
    let filename = fnameescape(fnamemodify(a:line, ':t:r'))
    " Close CtrlP
    call ctrlp#exit()
    exec "normal a". filename ."\<Esc>"
  elseif a:action =~ '^[v]$'
    " Get the filename
    let filename = fnameescape(fnamemodify(a:line, ':t'))
    " Close CtrlP
    call ctrlp#exit()
    exec "normal a". filename ."\<Esc>"
  else
    " Use CtrlP's default file opening function
    call call('ctrlp#acceptfile', [a:action, a:line])
  endif
endfunction
let g:ctrlp_open_func = { 'files': 'YankFilenameFunc' }

" dwm config
let g:dwm_master_pane_width = 130

" airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" signify (VCS status in the sign column)
let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1

if exists("neocomplcache")
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

	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	return neocomplcache#smart_close_popup() . "\<CR>"
	endfunction
	" <TAB>: completion.
	" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y> neocomplcache#close_popup()
	inoremap <expr><C-e> neocomplcache#cancel_popup()
	" Close popup by <Space>.
	inoremap <expr><TAB> pumvisible() ? neocomplcache#close_popup() : "\<TAB>"
	let g:neocomplcache_enable_auto_select = 0

	" Enable omni completion.
	autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
	endif
	let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
endif

" Use ag not ack
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" Leader commands

" Alignment in visual mode
" comma-a: align block, asking for character
vmap <leader>a :Align<space>
" comma-A: align on =
vmap <leader>A :Align<space>=<CR>
" comma-H: align on =>
vmap <leader>H :Align<space>=><CR>
" comma-M: align a block of Markdown links
vmap <leader>M :Align!<space>lp2P0<space>http<space>{%<CR>

" comma-W: strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" comma-q: hard-wrap current paragraph
nnoremap <leader>q gqip
" comma-w: hard-wrap current line as though it was a paragraph
nnoremap <leader>w o<ESC>kgqip}dd
" comma-v: select the just-pasted text
nnoremap <leader>v `[v`]
" comma-[: put array element on a new line
nnoremap <leader>[ f,a<CR><ESC>
" Select just-pasted text
nnoremap gp `[v`]
" Set paste, paste some text, set nopaste
nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
" Word count current file
nnoremap <Leader>c :!wc -w '%'<CR>
" Strip inner whitespace in XML tags
autocmd FileType xml,pml nnoremap <Leader>t vitgeOWxvitp
" Convert hashrocket hash to new-style Ruby one
autocmd FileType ruby nnoremap <Leader>h f:xf=gea:<ESC>f=3x

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

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

" Command for reformatting JSON files
com! FormatJSON %!python -m json.tool

" Allow editing of OS X crontabs
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" From Gary Bernhardt's vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTRACT VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExtractVariable()
	let name = input("Variable name: ")
	if name == ''
		return
	endif
	" Enter visual mode (not sure why this is needed since we're already in
	" visual mode anyway)
	normal! gv

	" Replace selected text with the variable name
	exec "normal c" . name
	" Define the variable on the line above
	exec "normal! O" . name . " = "
	" Paste the original selected text to be the variable value
	normal! $p
endfunction
vnoremap <leader>rv :call ExtractVariable()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INLINE VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InlineVariable()
	" Copy the variable under the cursor into the 'a' register
	:let l:tmp_a = @a
	:normal "ayiw
	" Delete variable and equals sign
	:normal 2daW
	" Delete the expression into the 'b' register
	:let l:tmp_b = @b
	:normal "bd$
	" Delete the remnants of the line
	:normal dd
	" Go to the end of the previous line so we can start our search for the
	" usage of the variable to replace. Doing '0' instead of 'k$' doesn't
	" work; I'm not sure why.
	normal k$
	" Find the next occurence of the variable
	exec '/\<' . @a . '\>'
	" Replace that occurence with the text we yanked
	exec ':.s/\<' . @a . '\>/' . @b
	:let @a = l:tmp_a
	:let @b = l:tmp_b
endfunction
nnoremap <leader>ri :call InlineVariable()<cr>
