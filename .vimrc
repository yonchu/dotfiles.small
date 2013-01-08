"
"  .vimrc
"

"### Basic {{{
set nocompatible
let mapleader = ","
set scrolloff=5
set textwidth=0
set wrap
set autoread
set noswapfile

set hidden

set backspace=indent,eol,start

set formatoptions=lmoq
set vb t_vb=
set browsedir=buffer
set viminfo='50,<1000,s100,\"50

set modeline
set modelines=2

set clipboard+=unnamedplus,unnamed

"nnoremap <silent>x "_x

set mouse=a
if ! has("kaoriya")
  set mouse-=a
endif
set ttymouse=xterm2

command! Ev edit $MYVIMRC
command! Sv source $MYVIMRC
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

filetype plugin on

set nobackup
set writebackup

" Enable backup.
"set backup
"set backupdir=~/backup
"set directory=~/swap
" }}}


"### Apperance {{{
set title
set showmatch
set matchtime=1
set number
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<
set display=uhex
set splitbelow
set splitright

set lazyredraw
set ttyfast

nnoremap <Space>ow :<C-u>setlocal wrap! \| setlocal wrap?<CR>
" }}}


"### Colors {{{
syntax enable
if &term =~ "xterm-256color" || &term=~"screen-256color"
  set t_Co=256
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm
endif

" For TeraTerm
" user peculiar setting
"set term=builtin_linux
"set ttytype=builtin_linux

highlight ZenkakuSpace cterm=underline ctermfg=blue ctermbg=gray gui=underline guifg=blue guibg=gray
match ZenkakuSpace /　/

if exists('+colorcolumn')
  set colorcolumn=80
endif

set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

autocmd! FileType markdown hi! def link markdownItalic Normal
" }}}


"### StatusLine {{{
set showcmd
set showmode
set laststatus=2
set cmdheight=2
set ruler


set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=%3l/%-3L,%3v
highlight StatusLine term=none guifg=Black guibg=Gray gui=none ctermfg=Black ctermbg=Gray cterm=none
augroup InsertHook
 autocmd!
 autocmd InsertEnter * highlight StatusLine guifg=Black    guibg=DarkYellow gui=none ctermfg=Black    ctermbg=DarkYellow cterm=none
 autocmd InsertLeave * highlight StatusLine guifg=DarkBlue guibg=Gray       gui=none ctermfg=DarkBlue ctermbg=Gray       cterm=none
 "autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340 ctermfg=cyan
 "autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90 ctermfg=white
augroup END
" }}}


"### Indent {{{
set autoindent
set smartindent
set cindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
vnoremap < <gv
vnoremap > >gv

if has("autocmd")
  filetype plugin on
  filetype indent on

  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType csh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType eruby      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType gitcommit  setlocal sw=4 sts=4 ts=4 et nomodeline textwidth=72
  autocmd FileType gitconfig  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType make       setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=8 et textwidth=80
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vb         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et

  autocmd FileType html :set indentexpr=
  autocmd FileType xhtml :set indentexpr=
endif
" }}}


"### Completion {{{
set wildmenu
set wildchar=<tab>
set wildmode=list:longest
set history=1000
set complete+=k
set completeopt=menuone,preview

cnoremap <C-p> <Up>
cnoremap <Up>  <C-p>
cnoremap <C-n> <Down>
cnoremap <Down>  <C-n>
" }}}


"### Tags {{{
if has("autochdir")
  set autochdir
  set tags=tags;
else
  set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
endif

set notagbsearch

nnoremap <C-t>  <Nop>
nnoremap <C-t>n  :<C-u>tabnew<CR>
nnoremap <C-t>c  :<C-u>tabclose<CR>
nnoremap <C-t>o  :<C-u>tabonly<CR>
nnoremap <C-t>j  :<C-u>execute 'tabnext' 1 + (tabpagenr() + v:count1 - 1) % tabpagenr('$')<CR>
nnoremap <C-t>k  gT

nnoremap t  <Nop>
nnoremap tt  <C-]>
nnoremap tj  :<C-u>tag<CR>
nnoremap tk  :<C-u>pop<CR>
nnoremap tl  :<C-u>tags<CR>
" }}}


"### Search {{{
set wrapscan
set ignorecase
set smartcase
set noincsearch
set hlsearch

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

command! -nargs=+ Sgrep execute 'silent grep! <args>'

autocmd FileType qf nnoremap <buffer> q :ccl<CR>
autocmd FileType qf nnoremap <buffer> <ESC> :ccl<CR>

function! s:toggle_qf_window()
  for bufnr in range(1,  winnr('$'))
    if getwinvar(bufnr,  '&buftype') ==# 'quickfix'
      execute 'ccl'
      return
    endif
  endfor
  execute 'botright cw'
endfunction
nnoremap <silent> cw :call <SID>toggle_qf_window()<CR>

autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,Sgrep call s:auto_qf_open()
function! s:auto_qf_open()
  if len(getqflist()) != 0
    execute 'QuickfixStatusEnable'
    execute 'copen'
    execute 'redraw!'
  endif
endfunction

vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

nnoremap <expr> s* ':%s/' . expand('<cword>') . '/<C-r>"/gc<Left><Left>'
"nnoremap <expr> ss* ':%s/\<' . expand('<cword>') . '\>/<C-r>"/g'
"
vnoremap s* "vy:%s/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR>/<C-r>+/gc<Left><Left>
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>

vnoremap sv "vy:%s/\%V<C-r>+//gc<Left><Left><Left><Left>

:set helplang=ja,en
nnoremap <C-i>  :<C-u>help<Space>
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>
" }}}


"### Move {{{
nnoremap h <Left>
nnoremap j gj
nnoremap k gk
nnoremap l <Right>
nnoremap <Down> j
nnoremap <Up>   k

nmap 1 0
nmap 0 ^
nmap 9 $

inoremap  <C-a> <HOME>
inoremap  <C-e> <END>
if ! has('mac')
  inoremap <C-j> <Down>
  inoremap <C-k> <Up>
  inoremap <C-h> <Left>
  inoremap <C-l> <Right>
endif

inoremap  <C-q> <ESC>xi

cnoremap  <C-a> <HOME>
cnoremap  <C-e> <END>
cnoremap  <C-q> <BS>

noremap <Space>j <C-f>
noremap <Space>k <C-b>

map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bnext \| bdelete #<CR>
command! Bw :bnext \| bdelete #

map <kPlus> <C-W>+
map <kMinus> <C-W>-

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

nnoremap gb '[
nnoremap gp ']

nnoremap ( %
nnoremap ) %

nnoremap gc  `[v`]
vnoremap gc <C-u>normal gc<Enter>
onoremap gc <C-u>normal gc<Enter>

set virtualedit+=block

vnoremap v $h

nnoremap <C-o>  <Nop>
nnoremap <Space>m  :<C-u>marks<CR>

nnoremap <expr> gf  <SID>do_git_diff_aware_gf('gf')
nnoremap <expr> gF  <SID>do_git_diff_aware_gf('gF')
nnoremap <expr> <C-w>f  <SID>do_git_diff_aware_gf('<C-w>f')
nnoremap <expr> <C-w><C-f>  <SID>do_git_diff_aware_gf('<C-w><C-f>')
nnoremap <expr> <C-w>F  <SID>do_git_diff_aware_gf('<C-w>F')
nnoremap <expr> <C-w>gf  <SID>do_git_diff_aware_gf('<C-w>gf')
nnoremap <expr> <C-w>gF  <SID>do_git_diff_aware_gf('<C-w>gF')

function! s:do_git_diff_aware_gf(command)
  let target_path = expand('<cfile>')
  if target_path =~# '^[ab]/'  " with a peculiar prefix of git-diff(1)?
    if filereadable(target_path) || isdirectory(target_path)
      return a:command
    else
      " BUGS: Side effect - Cursor position is changed.
      let [_, c] = searchpos('\f\+', 'cenW')
      return c . '|' . 'v' . (len(target_path) - 2 - 1) . 'h' . a:command
    endif
  else
    return a:command
  endif
endfunction

inoremap jj <Esc>

command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction
" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>
" }}}


"### Edit {{{
nnoremap ZZ <Nop>
nnoremap <Space>r  :<C-u>registers<CR>

nnoremap vy viwy
nnoremap vp viwpviwy
nmap <silent>ye :let @"=expand("<cword>")<CR>

vnoremap zy "zy
vnoremap zp "zp

nnoremap <silent>cy ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent>cy c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent>ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

vnoremap <silent> cp "0p<CR>

augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END

inoremap <C-u>  <C-g>u<C-u>
inoremap <C-w>  <C-g>u<C-w>

command! Pt :setlocal paste! | setlocal paste?

inoremap <C-o> <ESC>:<C-U>YRPaste 'p'<CR>i

nmap y9 y$
nmap y0 y^

"autocmd BufWritePre * :%s/\s\+$//ge
"autocmd BufWritePre * :%s/\t/  /ge

inoremap <expr> ,df strftime('%Y/%m/%d %H:%M:%S')
inoremap <expr> ,dd strftime('%Y/%m/%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

map <Leader>j !python -m json.tool<CR>

inoremap <expr> ,r* repeat('*', 80 - col('.'))
inoremap <expr> ,r# repeat('#', 80 - col('.'))
inoremap <expr> ,r+ repeat('+', 80 - col('.'))
inoremap <expr> ,r- repeat('-', 80 - col('.'))
inoremap <expr> ,r= repeat('=', 80 - col('.'))
" }}}


"### Encoding {{{
set encoding=utf-8
set fileformats=unix,dos,mac

if &ambiwidth !=# 'auto'
  set ambiwidth=double
endif

if has("kaoriya")
  set fileencodings=guess,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
endif

set suffixes=.bk,.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

command! -bang -nargs=? Cp932 edit<bang> ++enc=cp932 <args>
command! -bang -nargs=? Eucjp edit<bang> ++enc=euc-jp <args>
command! -bang -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
command! -bang -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
command! Jis Iso2022jp
command! Sjis Cp932
" }}}


"### Misc {{{
if has("mac")
  command! OB :silent call s:open_browser()
  function! s:open_browser()
    try
      execute '!open -a Google\ Chrome %:p'
    finally
      execute 'redraw!'
    endtry
  endfunction

  :nnoremap <leader>om :silent !open -a Marked.app '%:p'<cr>:redraw!<cr>
endif

"# Default Skeleton File
augroup SkeletonAu
  autocmd!
  "autocmd BufNewFile *.sh 0r $HOME/.vim/my_templates/skel.sh
augroup END

if ! has('mac')
  set noimdisable
  set iminsert=0
  set imsearch=0
  set noimcmdline
endif

set timeout timeoutlen=1000 ttimeoutlen=75

nmap <silent><ESC><ESC> :nohlsearch<CR>:redraw!<CR><ESC>
" }}}

" vim: fdm=marker fen fdl=0
