" Plugins
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    Plugin 'tpope/vim-sensible'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-endwise'
    Plugin 'vim-scripts/AutoClose'
    Plugin 'terryma/vim-expand-region'
    Plugin 'nelstrom/vim-visual-star-search'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'jeetsukumaran/vim-filebeagle'
    Plugin 'jlanzarotta/bufexplorer'
    Plugin 'mhinz/vim-startify'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'the31k/vim-colors-tayra'

    call vundle#end()
    filetype plugin indent on

" Looks
    syntax enable
    colorscheme tayra
    let g:airline_theme = 'wombat'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#right_sep = ''
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    set number
    set list " Show invisible characters
    set listchars=tab:>-,trail:~,extends:>,precedes:<

" Shortcuts
    " I really like space as a leader
    let mapleader = "\<Space>"

    " Reloads the saved $MYVIMRC
    map <leader>s :source $MYVIMRC<CR>

    " e finds open buffers
    map <leader>e :BufExplorer<CR>

    " Paste something
    map <leader>p :setlocal paste !<CR>

    " Save file
    map <Leader>w :w<CR>
    map <Leader>q :q<CR>
    map <Leader>Q :qa<CR>

    " v expands visual selection
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

    " go gives you newline without insert
    map go o<esc>k

    " H & L goes to start & end of line
    map H ^
    map L $

    " K splits line, inverse of J
    function! BreakHere()
        s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
        call histdel("/", -1)
    endfunction
    noremap K :call BreakHere()<CR>

    " * finds current, don't skip ahead please
    map * *N

    " clipboard buffer access
    map <leader>c "+

" Navigation
    " Switch buffers
    map <leader>J :bprev<CR>
    map <leader>K :bnext<CR>
    " Switch tabs easily
    map <tab>j :tabprevious<CR>
    map <tab>k :tabnext<CR>
    " Exit buffer nicely keeping window open
    command! BW :bn|:bd#
    map <leader>x :BW<CR>

    set mouse=n
    nnoremap <LeftMouse> <nop>

    " Open split with y or u
    set splitbelow
    set splitright
    map <leader>y :split<CR>
    map <leader>u :vsplit<CR>

    " Switch between split windows
    map <leader>h <C-w>h
    map <leader>j <C-w>j
    map <leader>k <C-w>k
    map <leader>l <C-w>l
    map <c-k> :resize -5<CR>
    map <c-j> :resize +5<CR>
    map <c-h> :vertical resize +5<CR>
    map <c-l> :vertical resize -5<CR>
    " Stop doing that!
    inoremap <Up> <esc>
    inoremap <Down> <esc>
    inoremap <Left> <esc>
    inoremap <Right> <esc>

    " star search
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

    " Folding based on indents
    set foldmethod=indent
    set foldlevelstart=4

    " Enter switches fold
    map <silent> <Return> @=(foldlevel('.')?'za':"\<Return\>")<CR>
    set foldtext=""

    " Center cursor
    set so=50

    " filebeagle with -, startify with _
    map _ :Startify<CR>

" Searching
    " Case only matters when I ask
    set ignorecase
    set smartcase

    " Highlight search results incrementally
    set hlsearch
    set incsearch

    " Turn off search with g-h
    map gh :silent noh<CR>

" Backup and externals
    set hidden
    set swapfile
    set directory=$TMPDIR,~/.tmp,~/.vim/tmp,/tmp,/var/tmp
    set backup
    set backupdir=$TMPDIR,~/.tmp,~/.vim/tmp,/tmp,/var/tmp

    if has('persistent_undo')
        set undodir=$TMPDIR,~/.tmp,~/.vim/tmp,/tmp,/var/tmp
        set undofile
        set undoreload=10000
    end
    set undolevels=10000

" Indents and  styling
    " Use spaces instead of tabs
    set expandtab

    " Be smart when using tabs/indents
    set smarttab
    set smartindent

    " 1 tab == 4 spaces, the only correct way
    set shiftwidth=4
    set tabstop=4

    " Wrap lines
    set formatoptions=1
    set breakindent
    set nowrap
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/

" Spell Check
    " Spell check toggle ,ss
    map <leader>ss :setlocal spell ! spelllang=en_ca<CR>

    " Spell check shortcuts
    map <leader>sn ]s<CR>
    map <leader>sp [s<CR>
    map <leader>sa zg<CR>
    map <leader>s? z=<CR>

" Abbreviations
    iab #i #include
    iab #d #define
    iab teh the
    iab erturn return
    iab retrun return
    iab seperate separate
    iab dont don't
    iab waht what
    iab tehn then

" Misc
    " God damn Ex mode
    map Q <nop>
    " I've never needed this
    map q: <nop>
    " Hack for http://vim.wikia.com/wiki/Fix_arrow_keys_that_display_A_B_C_D_on_remote_shell
    inoremap [A <nop>
    inoremap [B <nop>
    inoremap [C <nop>
    inoremap [D <nop>
    " json
    autocmd BufNewFile,BufRead *.json setf javascript
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    let g:startify_list_order = [['   Current directory:'], 'dir']
    let g:startify_custom_header = [
            \ '                               ',
            \ '            __                 ',
            \ '    __  __ /\_\    ___ ___     ',
            \ '   /\ \/\ \\/\ \ /'' __` __`\  ',
            \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \  ',
            \ '    \ \___/  \ \_\ \_\ \_\ \_\ ',
            \ '     \/__/    \/_/\/_/\/_/\/_/ ',
            \ ]
