" Plugins
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    Plugin 'tpope/vim-sensible'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-endwise'
    Plugin 'tpope/vim-commentary'
    Plugin 'jeetsukumaran/vim-filebeagle'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'bling/vim-airline'
    Plugin 'terryma/vim-expand-region'
    Plugin 'digitaltoad/vim-jade'
    Plugin 'wavded/vim-stylus'
    Plugin 'vim-scripts/AutoClose'
    Plugin 'nelstrom/vim-visual-star-search'
    Plugin 'w0ng/vim-hybrid'

    call vundle#end()
    filetype plugin indent on

" Looks
    syntax enable
    set background=dark
    colorscheme hybrid

    let g:airline#extensions#tabline#enabled = 1

    " Show line number
    set number
    set relativenumber

    set ttyfast
    set list " Show invisible characters
    set listchars=tab:>-,trail:~,extends:>,precedes:<

" Shortcuts
    " I really like space as a leader
    let mapleader = "\<Space>" 

    " Reloads the saved $MYVIMRC
    map <leader>s :source $MYVIMRC<CR>

    " Opens $MYVIMRC for editing
    map <leader>v :e $MYVIMRC<CR>

    " Paste something
    map <leader>p :setlocal paste !<CR>

    " Open file
    map <Leader>o :CtrlP<CR>

    " Save file
    map <Leader>w :w<CR>
    map <Leader>q :q<CR>
    map <Leader>z :wq<CR>

    " v expands visual selection
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

    " go gives you newline without insert
    map go O<esc>j

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
    map <c-k> :resize +5<CR>
    map <c-j> :resize -5<CR>
    map <c-h> :vertical resize +5<CR>
    map <c-l> :vertical resize -5<CR>

    noremap <c-f> /\_^\w\+\s\(\w\+\:\:\)*\(<C-r><C-w>\)<CR>
    noremap <c-d> /\_^\w\+\s\(\w\+\:\:\)*

    " Folding based on indents
    set foldmethod=indent
    set foldlevelstart=1

    " Enter switches fold
    map <silent> <Return> @=(foldlevel('.')?'za':"\<Return\>")<CR>
    set foldtext=""

    " Set 7 lines to the cursor
    set so=50

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
    map gh :silent noh<CR>

    " Super cool search function
    vmap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
        \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
    omap s :normal vs<CR>

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

    " Be smart when using tabs
    set smarttab

    " 1 tab == 4 spaces
    set shiftwidth=4
    set tabstop=4

    " Smart indent
    set si

    " Wrap lines
    set formatoptions=1
    set linebreak
    set breakindent
    set nowrap
    highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
    match OverLength /\%81v.*/

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
    iab iv I've
    iab il I'll
    iab dont don't
    iab waht what
    iab tehn then

" Misc
    " God damn Ex mode
    map Q <nop>
    " F1 is good enough
    map K <nop>
    " I've never needed this
    map q: <nop>
    " json
    autocmd BufNewFile,BufRead *.json setf javascript
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Start with directory when empty
function! InsertIfEmpty()
    if line('$') == 1 && col('$') == 1 && @% == ""
        " File doesn't exist yet
        FileBeagle
    endif
endfunction

au VimEnter * call InsertIfEmpty()
