if !isdirectory(expand("~/.vim/bundle/vundle"))
    call system("git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle")
endif
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'junegunn/vim-easy-align'
Bundle 'vim-scripts/closetag.vim'
Bundle 'othree/html5.vim'
Bundle 'rstacruz/sparkup'
Bundle 'scrooloose/nerdtree'

" Automatically install bundles on first run
if !isdirectory(expand("~/.vim/bundle/vim-airline"))
    execute 'silent BundleInstall'
    execute 'silent q'
endif

" Enable syntax highlighting
syntax on

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Recognize filetypes
filetype on
filetype plugin on
filetype indent on

" Highlight search terms
set hlsearch

" Don't wrap text
set nowrap

" Enable relative numbers only when needed
set number
autocmd FocusLost * :set norelativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
autocmd CursorMoved * :set relativenumber

" Incremental search
set incsearch

" Turn off highlighting of previous search
noremap <C-n> :nohlsearch<CR>

" Map leader key
let mapleader = ","
let g:mapleader = ","
let g:user_emmet_leader_key = '<C-e>'

" White space settings
set ts=2
set sts=2
set sw=2
set expandtab

" Better buffer management
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>t :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Toggle NERDTree
map <Leader>n :NERDTreeToggle<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Display extended tab completions on cmd menu
set wildmode=list:longest

" Set case insensivity and smart replace
set ignorecase
set smartcase

" Indent to correct spot after return
set smartindent

" Specifies which keys trigger reindenting in insert mode.
set cinkeys-=0#

" Set terminal title to vim title
set title

" Display bottom horizontal scrollbar on GUI
set guioptions+=b

" scroll offset in lines when cursor is around the edge of viewport
set scrolloff=3

" Gather all swap files in a single location
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" "dark" or "light", used for highlight colors
set background=light

" Scroll viewport using CTRL-c and CTRL-y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Display cursor position
set ruler

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\     if line("'\"") > 0 && line ("'\"") <= line("$") |
\         exe "normal g'\"" |
\     endif |
\ endif

" Enable paste mode on F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Don't show when you are in insert mode
set noshowmode

" Disable bell and visalbell
set visualbell t_vb=

" Enable mouse in insert mode
set mouse=i

" Display a column on 80th char
set colorcolumn=80

" automatically read file when changed outside of Vim
set autoread

" Default encoding
set encoding=utf-8

" Allow first line comment configurations for each file
set modeline
set modelines=5

" Show possible completions on command line
set wildmenu

" List all options and complete
set wildmode=list:longest,full

" Ignore certain files in tab-completion
set wildignore=*.class,*.o,*~,*.pyc,.git,third_party,node_modules

" Automatically reload vimrc after it's changed
autocmd! bufwritepost .vimrc source %

" Catch trailing whitespace, set to always on
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Get airline enabled on all views
set laststatus=2

" Mode Setting
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_python_checkers=['flake8', 'pyflakes']
let g:syntastic_python_flake8_args="--select=W402,W403,W404,W405,W801,W802,W803,W804,W805,W806"
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['python', 'javascript'],
                           \ 'passive_filetypes': ['html'] }

" Enable ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|build|npm-cache|pip-cache)|(\.(swp|ico|git|svn))$'


" Airline customizations
let g:airline_powerline_fonts = 1
if !exists("g:airline_symbols")
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_section_y = airline#section#create(['%p', '%%'])
let g:airline_section_z = airline#section#create_right(['%l', '%c'])
