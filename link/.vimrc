set nu
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set showcmd
set guifont=Consolas:h11
set hlsearch
set notimeout
set ttimeout
set autoread
set ignorecase
set wildignorecase
set smartcase
set incsearch
set backspace=indent,eol,start
set laststatus=2

syntax enable
let g:solarized_termtrans = 1
colorscheme solarized
set background=dark

set colorcolumn=81
highlight ColorColumn guibg=#f8f8f8 guifg=red

map <Space> <Leader>

map  <Help> <Esc>
map! <Help> <Esc>
map  <Insert> <Esc>
map! <Insert> <Esc>

noremap <leader>a ggVG

noremap <leader>y "*y
noremap <leader>p :set paste<CR>"*p:set nopaste<CR>
noremap <leader>d "*d
noremap <leader>c "*c

noremap <leader>w :w<CR>

noremap <leader>h <C-w>h
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l

ca vsb vert sb

nnoremap <silent><leader>n :set relativenumber!<cr>
autocmd InsertEnter * silent! :set norelativenumber
autocmd InsertLeave * silent! :set relativenumber
autocmd WinEnter * silent! :set relativenumber
autocmd WinLeave * silent! :set norelativenumber

if exists('$TMUX')
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
else
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
endif

set timeoutlen=1000 ttimeoutlen=0

" :w!! = :w with sudo
cmap w!! w !sudo tee > /dev/null %

" Saves a session every time vim is quit. Helps in case of accidental quits.
function! SaveSession()
    execute 'mksession ~/.vim/sessions/' . strftime('%Y-%m-%d_%H-%M-%S') . '.session'
endfunction

autocmd VimLeave * call SaveSession()
