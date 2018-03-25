filetype plugin indent on    " required

set nocompatible
set joinspaces
"set mouse=a
"set mousemodel=extend
set ruler
set shortmess=at
set cmdheight=2
set showmatch
set showcmd
set showmode
set autowrite
"set spell

set encoding=utf-8
set fileencodings=utf-8,gb18030,utf-16,big5

set viminfo='50,\"200,/20,:50,%,h
set wildmode=longest,list,full

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

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>


augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

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
set tabstop=4

au FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
au FileType ruby setlocal shiftwidth=4 softtabstop=4 expandtab

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
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

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

