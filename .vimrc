""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather then Vi settings (much better!).
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi StatusLine guifg=black guibg=white
set nocompatible    " Unable Vi compatibility
set ttyfast
set wildmode=longest,list
set autowrite
set textauto
set winminheight=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showcmd                       " Show incomplete cmds down the bottom
set showmode                      " Show current mode down the bottom
set clipboard=autoselectplus      " save the selection into the system clipboard
set ruler                         " Ruler on
set number                        " Display line numbers
set timeoutlen=10                 " Time to wait after ESC (default causes an annoying delay)
set nobackup
set hlsearch                      " Highlight search strings
set nowritebackup
set winaltkeys=yes
set modeline
set shortmess+=filmnrxoOtT
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set history=1000
set gdefault
set autoread
syntax enable

"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

"buffer check
set hidden

colorscheme railscasts
"set background=dark
"colorscheme solarized

set wildmenu
set numberwidth=5
set scrolloff=10
"set statusline=%<%F%h%m%r%h%w\ %y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ %{fugitive#statusline()}\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
set statusline=%<%F%h%m%r%h%w%=\ %{fugitive#statusline()}\ lin:%l\,%L\ col:%c%V\ %P
set expandtab
set formatoptions=rq
set t_Co=256

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stupid shift key fixes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CLIPBOARD
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

nnoremap <silent><C-n> :tabnext<CR>
nnoremap <silent><C-p> :tabprevious<CR>
"noremap <C-j> :bprev<CR>
"noremap <C-k> :bnext<CR>

let g:buftabs_only_basename=1
let g:buftabs_in_statusline=1

if &diff
  nnoremap <silent><C-j> :diffget LOCAL<CR>
"  nnoremap <silent><C-.> :diffget BASE<CR>
  nnoremap <silent><C-k> :diffget REMOTE<CR>

  set background=dark
  colorscheme zenburn
endif

map <F3> :TlistToggle<CR>
map <F5> :SyntasticCheck<CR>
map <F4> :SyntasticToggleMode<CR>
map <F10> :set paste<CR>
map <F9>  :set wrap!<Bar>set wrap?<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch       " Show matching brackets.
set matchtime=8     " Bracket blinking.
set novisualbell    " No blinking .
set noerrorbells    " No noise.
set vb t_vb="."
set laststatus=2    " Always show status line.
set tabpagemax=50   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2                                   " Tabs are 2 spaces
set shiftwidth=2                                " Define the width of a shift for the<<  and>>  commands. (Tabs under smart indent)
set softtabstop=4                               " Define whattabstop  is to be simulated when Tab is pressed
set autoindent                                  " Automatically indent eache line like previous one
set smartindent                                 " Automatically indent when adding a curly bracket, etc.
set backspace=indent,eol,start                  " Allow backspacing over everything in insert mode
set smarttab                                    " Insert indents at the beginning os a line
set cinwords=if,else,while,do,for,switch,case   " Define keywords that cause an extra indent
set lbr
set nowrap

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8

filetype plugin indent on

set autochdir
set fileformats=unix,mac,dos
set iskeyword+=_,$,@,%,#

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialize Pathogen for script handling
"   just add scripts to ~/.vim/bundle/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set nofoldenable        " dont fold by default

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntax stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let html_wrong_comments=1
  let php_sql_query = 1
  let php_baselib = 1
  let php_htmlInStrings = 1
  let hs_highlight_delimiters = 1
  let hs_highlight_boolean = 1
  let hs_highlight_types = 1
  let java_javascript=1
  let java_css=1
  let msql_sql_query = 1
  let apache_version = "2.0"
  let enforce_freedesktop_standard = 1
  let python_highlight_all = 1

  let g:syntastic_always_populate_loc_list=1
  let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']

"  let g:is_bash = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERD_tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  map <F7> :execute 'NERDTreeToggle ' . getcwd()<CR>
  let NERDChristmasTree = 1
  let NERDTreeCaseSensitiveSort = 1
  let NERDTreeIgnore = ['\~$','\.[ao]$','\.swp$','\.DS_Store','\.pyc','\.pyo']
  let NERDTreeMouseMode = 2
  let NERDTreeShowHidden = 1
  let NERDTreeChDirMode = 2
  let NERDTreeWinPos = "right"
  let NERDTreeWinSize = 50

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch   " Search as you type
set ignorecase  " Ignore case when searching
set smartcase   "

set ofu=syntaxcomplete#Complete

" Trailing or broken whitespace.
let c_space_errors=1
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
set backupcopy=auto,breakhardlink

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Improved status bar - airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode " get rid of the default mode indicator
let g:airline#extensions#tabline#enabled = 1
set fillchars+=stl:\ ,stlnc:\
let g:airline_section_c = '%F'
let g:airline_section_y = '-%L-'

let g:bufferline_echo = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#ctrlp#color_template = 'visual'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#empty_message = 'git it!!'


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
  augroup END

  autocmd FileType python set tabstop=8 expandtab shiftwidth=4 softtabstop=4 omnifunc=pythoncomplete#Complete
  autocmd FileType html set softtabstop=3 shiftwidth=3 textwidth=0 omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set softtabstop=2 shiftwidth=2 textwidth=0 omnifunc=csscomplete#CompleteCSS
  autocmd FileType c,cpp,java,php,module,tpl.php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  au BufNewFile,BufRead *.wsgi set filetype=python
  au FileType javascript call JavaScriptFold()

endif
