" Pathogen (https://github.com/tpope/vim-pathogen) plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-sensible   https://github.com/tpope/vim-sensible
" vim-surround   https://github.com/tpope/vim-surround
" vim-fugitive   https://github.com/tpope/vim-fugitive
" vim-endwise    https://github.com/tpope/vim-endwise
" autoclose      http://www.vim.org/scripts/script.php?script_id=1849
" vim-markdown   https://github.com/tpope/vim-markdown
" vim-autoformat https://github.com/Chiel92/vim-autoformat
" vim-airline    https://github.com/bling/vim-airline
" ctrlp.vim      https://github.com/kien/ctrlp.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

execute pathogen#infect()
set runtimepath^=~/.vim/bundle/ctrlp.vim
colorscheme darkblue

" Show top tabline
let g:airline#extensions#tabline#enabled = 1

" Switch tabs easily
map <C-Right> :tabnext<esc>
map <C-Left> :tabprev<esc>

" Leader key is comma
let mapleader = ","

" Map <Space> to / (search)
map <space> /

" Let me know when I'm cmd
set showcmd

" Show line number
set number

" Turn backup off, since most stuff is in git anyway
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Auto indent
set ai
" Smart indent
set si
" Wrap lines
set wrap

" Reloads the saved $MYVIMRC
map <leader>s :source $MYVIMRC<esc>

" Opens $MYVIMRC for editing
map <leader>v :e $MYVIMRC<esc>

" Paste something
map <leader>p :setlocal paste !<esc>

" Spell check toggle ,ss
map <leader>ss :setlocal spell! spelllang=en_ca<cr>
