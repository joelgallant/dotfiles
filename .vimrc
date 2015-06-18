" Pathogen (https://github.com/tpope/vim-pathogen) plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-sensible   git@github.com:tpope/vim-sensible.git
" vim-surround   git@github.com:tpope/vim-surround.git
" vim-fugitive   git@github.com:tpope/vim-fugitive.git
" vim-endwise    git@github.com:tpope/vim-endwise.git
" autoclose      http://www.vim.org/scripts/script.php?script_id=1849
" vim-jade       git@github.com:digitaltoad/vim-jade.git
" vim-stylus     git@github.com:wavded/vim-stylus.git
" vim-autoformat git@github.com:Chiel92/vim-autoformat.git
" vim-airline    git@github.com:bling/vim-airline.git
" ctrlp.vim      git@github.com:kien/ctrlp.vim.git
" vim-expand-region git@github.com:terryma/vim-expand-region.git
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
    let mapleader = "\<Space>" 
    
    " Reloads the saved $MYVIMRC
    map <leader>s :source $MYVIMRC<esc>

    " Opens $MYVIMRC for editing
    map <leader>v :e $MYVIMRC<esc>

    " Paste something
    map <leader>p :setlocal paste !<esc>

    " Open file
    nnoremap <Leader>o :CtrlP<CR>

    " Save file
    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>q :q<CR>

    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

" Navigation
    " Switch tabs easily
    map <leader>j :bprev<esc>
    map <leader>k :bnext<esc>
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
    autocmd BufNewFile,BufRead *.json setf javascript

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
    
    " Super cool search function
    vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
        \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
    omap s :normal vs<CR>

" Backup and externals
    " Turn backup off, since most stuff is in git anyway
    set nobackup
    set nowb
    set noswapfile
    set hidden

    " Save quickly
    nmap <leader>w :w!<esc>

" Indents and  styling
    " Use spaces instead of tabs
    set expandtab

    " Be smart when using tabs
    set smarttab

    " 1 tab == 2 spaces
    set shiftwidth=2
    set tabstop=2

    " Smart indent
    set si
    " Wrap lines
    set wrap

    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Spell Check
    " Spell check toggle ,ss
    map <leader>ss :setlocal spell ! spelllang=en_ca<esc>

    " Spell check shortcuts
    map <leader>sn ]s<esc>
    map <leader>sp [s<esc>
    map <leader>sa zg<esc>
    map <leader>s? z=<esc>
