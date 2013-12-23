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

" Plugins
    execute pathogen#infect()
    set runtimepath^=~/.vim/bundle/ctrlp.vim
    
    let g:airline#extensions#tabline#enabled = 1

    let g:NERDTreeChDirMode=2
    
    " Go away NERDTree...
    let NERDTreeQuitOnOpen=1

" Looks
    colorscheme darkblue

    " Show line number
    set number

" Shortcuts
    let mapleader = "," 
    
    " Reloads the saved $MYVIMRC
    map <leader>s :source $MYVIMRC<esc>

    " Opens $MYVIMRC for editing
    map <leader>v :e $MYVIMRC<esc>

    " Paste something
    map <leader>p :setlocal paste !<esc>

" Navigation
    " Switch tabs easily
    map <C-J> :bprev<esc>
    map <C-K> :bnext<esc>
    map <C-Left> :tabprevious<esc>
    map <C-Right> :tabnext<esc>
    map <C-x> :bd<esc>
 
    " Open NERDTree
    map <C-f> :NERDTreeToggle<esc>

    " Folding based on indents
    set foldmethod=indent
    set foldlevelstart=99
    nnoremap <silent> <Return> @=(foldlevel('.')?'za':"\<Return\>")<esc>
    set foldtext=""

    " Set 7 lines to the cursor
    set so=7

" Searching
    " Ignore case when searching
    set ignorecase

    " When searching try to be smart about cases 
    set smartcase

    " Highlight search results
    set hlsearch

    " Show search as I'm typing
    set incsearch

    " Turn off search with Ctrl-H
    nmap <silent> <C-h> :silent noh<esc>

" Backup and externals
    " Turn backup off, since most stuff is in git anyway
    set nobackup
    set nowb
    set noswapfile

    " Save quickly
    nmap <leader>w :w!<esc>

" Indents and  styling
    " Use spaces instead of tabs
    set expandtab

    " Be smart when using tabs
    set smarttab

    " 1 tab == 4 spaces
    set shiftwidth=4
    set tabstop=4

    " Smart indent
    set si
    " C style indent
    set cindent
    " Wrap lines
    set wrap
    
    " Autoformat uses Java (I'm a java dev, so...)
    let g:formatprg_args_java = "--style=java"

" Spell Check
    " Spell check toggle ,ss
    map <leader>ss :setlocal spell ! spelllang=en_ca<esc>

    " Spell check shortcuts
    map <leader>sn ]s<esc>
    map <leader>sp [s<esc>
    map <leader>sa zg<esc>
    map <leader>s? z=<esc>
