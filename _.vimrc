" Note: This .vimrc file uses Vim folding. Toggle a fold with `za`.

"*****************************************************************************
"{{{1 VUNDLE PLUGIN MANAGER BEGIN
"*****************************************************************************

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible              " be iMproved, required
filetype off                  " required

let vundle_exists=expand('~/.vim/bundle/Vundle.vim')

if !isdirectory(vundle_exists)
  echoerr "You have to first install Vundle yourself! https://github.com/VundleVim/Vundle.vim"
  execute "q!"
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"*****************************************************************************
"{{{2 Vundle install plugins begin

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"-----------------------------------------------------------------------------
"{{{3 Plugins suggested by https://vim-bootstrap.com/

Plugin 'scrooloose/nerdtree'         " Vim file browser
Plugin 'tpope/vim-fugitive'          " :Gcommit and other similar commands

Plugin 'dense-analysis/ale'          " Asynchronous Lint Engine {{{4
let g:ale_fix_on_save = 0            " Maybe set to 1
let g:ale_linters_explicit = 0       " Maybe set to 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'sh': ['shellcheck'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma --no-semi es5'
" }}}4

Plugin 'jelera/vim-javascript-syntax'
Plugin 'derekwyatt/vim-scala'        " Scala

"-----------------------------------------------------------------------------
"{{{3 garrettheath4 custom plugins

Plugin 'jaredgorski/SpaceCamp'         " Modern Vim colorscheme
Plugin 'machakann/vim-columnmove'      " Move cursor in vertical-only direction by M-f,t,F,T, `;`, `,`
Plugin 'godlygeek/tabular'             " :Tabularize to align text tables
Plugin 'elzr/vim-json'                 " JSON
Plugin 'maksimr/vim-jsbeautify'        " :call JsBeautify()
Plugin 'othree/xml.vim'                " XML
Plugin 'AnsiEsc.vim'                   " :AnsiEsc to Interpret ANSI esc sequences
Plugin 'Xuyuanp/nerdtree-git-plugin'   " Git plugin for nerdtree (nerdtree req'd)

"-----------------------------------------------------------------------------
"{{{3 OS-specific plugins

if has("mac")
  " List Mac-specific Vundle plugin packages here
  Plugin 'darfink/vim-plist'
endif

"}}}2 Vundle install plugins end
"*****************************************************************************

"*****************************************************************************
"{{{2 Vundle finish initialization

" All of your Plugins must be added before the following line
call vundle#end()             " required
filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"}}}2 Vundle finish initialization
"*****************************************************************************

"*****************************************************************************
"}}}1 VUNDLE PLUGIN MANAGER END
"*****************************************************************************

"*****************************************************************************
"{{{1 GENERAL VIM CONFIGURATIONS
"*****************************************************************************

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup  " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif
set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set guioptions-=T
  try
    colorscheme SpaceCamp
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme koehler
  endtry
  syntax on
  hi Error guifg=Yellow guibg=Red ctermfg=8 ctermbg=1
  set hlsearch
  set cursorline
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "filetype plugin indent on         " Already turned on in Vundle block at top

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent  " always set autoindenting on

endif " has("autocmd")

" Alter the sort sequence for the Netrw Directory Listing
" g:netrw_sort_sequence = [\/]$,\<core\%(\.\d\+\)\=\>,\.c$,\.cpp$,\.h$,\.txt$,\.in$,\.out$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$

set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set copyindent
set preserveindent
set nojoinspaces    " nojoinspaces => only 1 period after spaces when reformatting
set incsearch
set scrolloff=1
set ruler
set exrc
set backspace=2
set number
set list            " Show formatting characters
" Show <Tab> as >-- and trailing spaces as ~
set listchars=tab:>-,trail:~,extends:>,precedes:<
" Set color of eol, extends, and precedes to black (visible only when editing line)
highlight NonText    ctermfg=0 guifg=Black
" Set color of nbsp, tab, and trail to dark gray
highlight SpecialKey ctermfg=8 guifg=DarkGray
set modeline
set modelines=3
if has("gui_running") && !exists("mvim")
  set autochdir
  set lines=85
  set columns=85
endif

" vim: set tabstop=2 shiftwidth=2 vts=2 smarttab softtabstop=2 shiftround expandtab foldmethod=marker:
