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
    colorscheme pablo

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
    map <leader>J :bprev<esc>
    map <leader>K :bnext<esc>
    map <tab>h :tabprevious<esc>
    map <tab>l :tabnext<esc>
    command! BW :bn|:bd#
    map <leader>x :BW<esc>

    set splitbelow
    set splitright
    nnoremap <C-n>n :split 
    nnoremap <C-n>m :vsplit 
    
    " Switch between split windows
    noremap <leader>h <C-w>h
    noremap <leader>j <C-w>j
    noremap <leader>k <C-w>k
    noremap <leader>l <C-w>l
    noremap <leader>+ :resize +5<esc>
    noremap <leader>- :resize -5<esc>
    noremap <leader>9 :vertical resize +5<esc>
    noremap <leader>0 :vertical resize -5<esc>

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

    " History is cheap
    set history=200

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

" Abbreviations
    iab #i #include 
    iab #d #define 
    iab s struct 
    iab t typedef 
    iab teh the
    iab erturn return
    iab retrun return
    iab seperate separate
    iab i I
    iab iv I've
    iab il I'll
    iab dont don't
    iab waht what
    iab tehn then

" God damn Ex mode
nnoremap Q <nop>
