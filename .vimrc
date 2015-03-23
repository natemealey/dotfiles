"set up appearance
syntax on
let base16colorspace=256
set t_Co=256
set background=dark
colorscheme base16-default
set number
set cc=80

"set up spell checker
set spelllang=en

"set up mouse bindings fuck the haters
set mouse=a
map <ScrollWheelUp> 3<C-Y>
map <ScrollWheelDown> 3<C-E>

"set space as a leader key in normal mode
let mapleader = " "
"and space+o/O make a new line then go back to normal mode
map <Leader>o o <Esc>
map <Leader>O O <Esc>

"fix issue where pasting with autoindent ruins everything
set pastetoggle=<F6>

"set easy toggles between buffers
map ]b :bn<CR>
map [b :bp<CR>

"set up tabbing/indentation
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set cindent

"set up wrapping
set wrap
set linebreak
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

"modify search keys to center the result
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"make shift+y act like shift+d and shift+c (instead of yy)
noremap Y y$

"allow h/l and arrows to wrap lines
set whichwrap+=<,>,h,l,[,]

"set up pathogen
execute pathogen#infect()
filetype plugin indent on

"fix vimsplitting being done in a stupid way by default
set splitbelow
set splitright

"switch between vimsplits with C-H/J/K/L
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"set up syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"please shut up about C++11 syntastic, it works I swear to god
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

"fix error with fish shell's incompatibility with syntastic
set shell=/bin/bash

"set up NERDTree to run automatically
autocmd vimenter * NERDTree
"and to quit automatically
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()
"and to go to editor window when opened
autocmd VimEnter * wincmd p

"set up backup and centralized swapfiles
set backup
set directory=~/.vim/swps
set backupdir=~/.vim/backup

"allow line shifting up and down using <cmd+option+h/l/up/down>
"fixes mappings of OSX's alt key
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv
