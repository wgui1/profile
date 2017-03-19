set noautoindent
set nocompatible
set joinspaces
set mouse=a
set mousemodel=extend
set ruler
set shortmess=at
set cmdheight=2
set showmatch
set showcmd
set showmode
"set spell

set encoding=utf-8
set fileencodings=utf-8,gb18030,utf-16,big5

set viminfo='50,\"200,/20,:50,%,h
set wildmode=longest,list,full

set clipboard=unnamed,autoselect
" ************************************************************************
" set cursorline
" set cursorcolumn

" ************************************************************************
" Line wrap option, don't change the buffer, but relate with display
set wrap
set linebreak

" ************************************************************************
" indent and tab options
" hereafter the tab stop strategy compatible with other env with tabstop=8
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

au FileType python setlocal shiftwidth=3 softtabstop=3 expandtab
au FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab

" ************************************************************************
" Backup option
set nobackup
set backupdir=/tmp
set writebackup

" ************************************************************************
" Search option
set ignorecase
set smartcase
set incsearch
set hlsearch

" ************************************************************************
" visual bell option
set vb t_vb=

" ************************************************************************
" delete option
set backspace=indent,eol,start

" ************************************************************************
" file type option
filetype indent plugin on
if has("autocmd") && exists("+omnifunc")
   autocmd Filetype *
        \ if &omnifunc == "" |
        \  setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif
" ************************************************************************
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"
set background=dark
colorscheme pablo 
if &t_Co > 2 || has("gui_running")
   syntax on
endif

" ************************************************************************
" command used for buffer explore
noremap	<C-P>	:bp<CR>
noremap	<C-N>	:bn<CR>

" command used for window explore
set wmw=0
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k

" ************************************************************************
" Abbreviations
"
ab teh the
iab YDATE <C-R>=strftime("%d/%m/%y")<CR>
" Example: 03/06/2003

" ************************************************************************
" Mappings
"
" Some quick mappings
map ml o<ESC>k " Make a blank line below the current line
map mL O<ESC>j " Make a blank line above the current line


" Key map for inserting new date.
" ,L  = "Last Change:" - replace old time stamp with a new one
"        preserving whitespace and using internal "strftime" command.
"        Requires the abbreviation  "YDATE".  Will exclude string with
"        quotes in front of string (so string in text is ignored).
"    Example:
"    before:  "Last Change: 07/09/03"
map ,l mz1G/^" Last Change: *<CR> /\d<CR> CYDATE<ESC>`z :noh<CR>

" Redefine keys for searches so that the search result is always in the middle
" of the screen.
" From Andrew W. Freeman [andrewf@voicenet.com] Thu 1999-05-13 11:36
nmap n nmzz.`z
nmap N Nmzz.`z
nmap * *mzz.`z
nmap # #mzz.`z
nmap g* g*mzz.`z
nmap g# g#mzz.`z

" ************************************************************************
" handy when push shift button too long 
command! Q  quit
command! W  write
command! Wq wq
nnoremap ,f zf]#
nnoremap <F9> :%s/\r//g<CR>
" ************************************************************************
" Begin autocommands
"
" Clear all autocommands
"au! " This broke the :syn on command.  Hmph.

" In text files, always limit the width of text to 78 characters.
autocmd BufRead *.txt set textwidth=78

map ,v :e         ~/.vimrc<CR>
map ,g :e         ~/.gvimrc<CR>
map ,s :source    ~/.vimrc<CR>
 
nnoremap   <F6> :cn<CR>
 
" Taglist parameter
let Tlist_Ctags_Cmd="/usr/bin/ctags"
nnoremap    <F8>    :Tlist<CR>
 
" edit the file in the same directory as the buffer file (thanks Douglas Potts)
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,d :cd <C-R>=expand("%:p:h") . "/" <CR> <CR>
set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags
set path=.,,,./**

cmap w!! w !sudo tee > /dev/null %

