if !isdirectory(expand("~/.vim/bundle/vundle"))
    call system("git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle")
endif
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'               " vundle is managed by vundle
Plugin 'kien/ctrlp.vim'                     " Control+P to open files quicly
Plugin 'fholgado/minibufexpl.vim'           " Buffer Explorer, that shows your buffers like tabs at the top
Plugin 'tpope/vim-fugitive'                 " Only the best Git wrapper of all time
Plugin 'vim-airline/vim-airline'            " Shows cool status line for your vim
Plugin 'vim-airline/vim-airline-themes'     " Even cooler themes for your airline
Plugin 'Lokaltog/vim-easymotion'            " Easily move around in files (<leader><leader>s)
Plugin 'vim-scripts/closetag.vim'           " Closes un closed tags (ctrl-_)
Plugin 'othree/html5.vim'                   " Syntax and autocomplete for html5 features
Plugin 'scrooloose/nerdtree'                " Opens a tree view of your project (<leader>n)
Plugin 'scrooloose/nerdcommenter'           " Comment operations, comment out lines easily ([count]<leader>c<space>)
Plugin 'terryma/vim-multiple-cursors'       " Adds multiple cursors in the editor like sublime (Ctrl+n) use it with visual (Ctrl+V)
Plugin 'leafgarland/typescript-vim'         " Adds TypeScript support
Plugin 'scrooloose/syntastic'               " Shows syntax errors reported by language helpers
Plugin 'posva/vim-vue'                      " support for VUE files
Plugin 'altercation/vim-colors-solarized'   " Color scheme for solarized
Plugin 'editorconfig/editorconfig-vim'      " Editorconfig support
Plugin 'mattn/emmet-vim'                    " Expand HTML syntax using CSS (<ctrl-y>,)
Plugin 'w0rp/ale'                           " Language Server Integration for Linters and Auto Formatters
" Plugin 'neoclide/coc.nvim'                  " Coc is an intellisense engine for vim8 & neovim.

call vundle#end()

" Automatically install bundles on first run
if !isdirectory(expand("~/.vim/bundle/vim-airline"))
    execute 'silent PluginInstall'
    execute 'silent q'
endif

" Enable syntax highlighting
syntax on

" Highligh mathches
set showmatch " highlight matching [{()}]

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Show white space
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

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

" Folding
set foldenable          " enable folding
set foldlevelstart=99   " open all folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
" space open/closes folds
nnoremap <space> za

" Map leader key
let mapleader = ","
let g:mapleader = ","
let g:user_emmet_leader_key = '<C-e>'

" Turn off highlighting of previous search
nnoremap <leader><esc> :nohlsearch<CR>

" White space settings
set ts=2
set sts=2
set sw=2
set expandtab

" Better buffer management
set hidden

" "dark" or "light", used for highlight colors
colorscheme solarized
let g:solarized_termcolors=256
set background=dark
call togglebg#map("<F5>")

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

" Enable mouse in all modes
set mouse=a

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
let g:ctrlp_custom_ignore = '\v[\/](submodules|offline-mirror|node_modules|target|dist|build|npm-cache|pip-cache)|(\.(swp|ico|git|svn))$'

" Airline customizations
let g:airline_powerline_fonts = 1
if !exists("g:airline_symbols")
    let g:airline_symbols = {}
endif

" A Nice dark theme
let g:airline_theme = 'powerlineish'

" Makes exiting insert mode faster
set ttimeoutlen=10

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
