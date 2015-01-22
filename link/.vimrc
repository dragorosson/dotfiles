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
set smartcase
set incsearch

set colorcolumn=81
highlight ColorColumn guibg=#f8f8f8 guifg=red

map <Space> <Leader>

map  <Help> <Esc>
map! <Help> <Esc>
map  <Insert> <Esc>
map! <Insert> <Esc>

noremap <leader>a ggVG

noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>d "+d
noremap <leader>c "+c

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
