""" PLUGINS
" load plugins
if filereadable(expand("~/.config/nvim/plug-manager.vim"))
  source ~/.config/nvim/plug-manager.vim
endif

""" Set Terminal Color
set t_Co=256
set background=dark

""" AESTHETICS
syntax on
colorscheme dracula
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none


""" OTHER CONFIGURATIONS
set hidden                " CoC: if hidden is not set, TextEdit might fail.
set cursorline            " highlight current line
set path=**               " Allow VIm to go through all dir and sub dir
set mouse=a               " enable mouse support
set backspace=2           " make backspace work like most other apps
set ruler                 " show the cursor position all the time
set showcmd               " display incomplete commands
set showmode              " display edit mode
set incsearch             " do incremental searching
set laststatus=2          " always display the status line
set history=1000          " sets how many lines of history VIM has to remember
set nowrap                " don't wrap long lines
set ignorecase            " /the would find 'the' or 'The', add \C if you want 'the' only
set smartcase             " while /The would find only 'The' etc.
set nopaste               " enable formatting while pasting
set pastetoggle=<F2>      " switch paste mode
set clipboard=unnamedplus " Copy paste between vim and everything else
set autowrite             " save file before switching a buffer
set autoindent            " indent
set showmatch             " highlight matching brackets
set lazyredraw            " redraw only when we need to"
set hlsearch              " highlight same words while searching with Shift + *
set encoding=UTF-8        " set file encoding
set title                 " show title
set showtabline           " show header tabs
set splitbelow            " Horizontal splits will automatically be below
set splitright            " Vertical splits will automatically be to the right
set fillchars+=vert:\

" additional config
set cmdheight=2           " better display for messages
set updatetime=200        " bad experience if default 4000
set shortmess+=c          " do not give |ins-completion-menu| messages
set signcolumn=yes        " always show signcolumns

" spell check
set spelllang=en,fr
autocmd FileType markdown,gitcommit,text setlocal spell spelllang=en_us
autocmd FileType text setlocal spell spelllang=en_us,fr

" spaces
set tabstop=2     " tab width
set shiftwidth=2  " indent size
set softtabstop=2 " simulated tab width
set expandtab     " spaces on tab press
set smartindent   " indent automatically
set shiftround    " uses shiftwidth when >, <

" show whitespaces
set list listchars=tab:»·,trail:·
" set list listchars=trail:»,tab:»-

" removes the delay when hitting esc in insert mode
set ttimeout
set ttimeoutlen=1

" line numbers
set number                          " show
set numberwidth=5                   " line numbers width
highlight LineNr guifg=#109fd2      " line number color: overrides dracula theme

" highlight trailing whitespaces
hi ExtraWhitespace ctermbg=172 guifg=#d78700
match ExtraWhitespace /\s\+$/

" automatically refresh changed files
set autoread

" recognizes filetype, plugins and indent
filetype plugin indent on

" Fold method definitions
set nofoldenable      " enable folding
set foldmethod=indent " fold based on indent level
set foldopen+=jump    " When jumping to line, folds on the line should be opened (:help 'foldopen')
set foldlevel=1
set foldnestmax=2

" turn off swap files
set noswapfile nobackup nowb

" completion
set wildmode=longest,full
set wildmenu                " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif


""" FILETYPES
" filetype: auto completion: ctrl+x ctrl+o to activate
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
          \	if &omnifunc == "" |
          \		set omnifunc=syntaxcomplete#Complete |
          \	endif
endif

" open large files > 10 MB
let g:LargeFile = 10 * 1024 * 1024
augroup LargeFile
  " files with filesize too large are recognized too (getfsize = -2)
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
  " no syntax highlighting if big file
  autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif
augroup END
function! LargeFile()
  set      eventignore+=FileType " no syntax highlighting etc
  setlocal bufhidden=unload      " save memory when other file is viewed
  setlocal undolevels=-1         " no undo possible
  setlocal foldmethod=manual
  setlocal noswapfile
endfunction


""" CUSTOM MAPPINGS
let mapleader=","
nmap <leader>ee :Colors<CR>
nmap <leader>ea :AirlineTheme
nmap <leader>im <Plug>(JsFileImport)
nmap <leader>t :call TrimWhitespace()<CR>
xmap <leader>a gaip*
nmap <leader>a gaip*
nmap <leader>s ysiw
nmap <leader>h :RainbowParentheses!!<CR>
nmap <leader>j :set filetype=journal<CR>
nmap <leader>k :ColorToggle<CR>
nmap <silent> <leader><leader> :noh<CR>

" ranger
nmap <leader>ff :RangerEdit<CR>
nmap <leader>fv :RangerVSplit<CR>
nmap <leader>fs :RangerSplit<CR>
nmap <leader>ft :RangerTab<CR>

" tab navigation
nnoremap <Tab>    :tabnext<CR>
nnoremap <S-Tab>  :tabprevious<CR>
nnoremap <C-t>    :tabnew<CR>

nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt
nmap <leader>0 10gt

" terminal
nmap <leader><leader>ss <C-w>s<C-w>j:terminal<CR>
nmap <leader><leader>sv <C-w>v<C-w>l:terminal<CR>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" close all buffers
nnoremap <leader><leader>C :bufdo bwipeout<CR>
nnoremap <leader><leader>c :bp\|bd #<CR>

" fzf
nnoremap <silent> <leader><leader>b :Buffers<CR>
nnoremap <silent> <leader><leader>f :GFiles .<CR>
nnoremap <silent> <leader><leader>F :Files<CR>
nnoremap <silent> <leader><leader>l :Lines<CR>
nnoremap <silent> <leader><leader>m :Maps<CR>

" search for visually selected textab
"   https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" grep selection with rg
xnoremap <leader>g y :Rg <CR>
nnoremap <Leader>g :Rg <C-r><C-w><CR>

nnoremap <leader>rg :Rg<Space>
vnoremap <leader>rg "gy:Rg<Space><C-r>g<CR>

" find & replace: in all files
"   after searching or text, press this mapping to do a project wide find and
"   replace. This one applies to all maches accross all files instead of just
"   the current file
nmap <leader><leader>r
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <leader><leader>r
  \ "sy
  \ gvgr
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" completion helper
"   global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" find & replace: in current file
"   Works by
"   1. Searching for word/pattern (to be replace)
"   2. Hit <leader>r to replace all found occurrences
nnoremap <leader>r :%s///g<Left><Left>

" toggle line numbers
nnoremap <silent> <C-m><C-m> :set invrelativenumber<CR>

" move line up / down with Alt + j / k
if has('macunix')
  nnoremap ∆ :m .+1<CR>==
  nnoremap ˚ :m .-2<CR>==
  inoremap ∆ <Esc>:m .+1<CR>==gi
  inoremap ˚ <Esc>:m .-2<CR>==gi
  vnoremap ∆ :m '>+1<CR>gv=gv
  vnoremap ˚ :m '<-2<CR>gv=gv
else
  nnoremap <A-j> :m .+1<CR>==
  nnoremap <A-k> :m .-2<CR>==
  inoremap <A-j> <Esc>:m .+1<CR>==gi
  inoremap <A-k> <Esc>:m .-2<CR>==gi
  vnoremap <A-j> :m '>+1<CR>gv=gv
  vnoremap <A-k> :m '<-2<CR>gv=gv
endif

" window resize (simply)
nnoremap <S-Left> :vertical resize -4<CR>
nnoremap <S-Right> :vertical resize +4<CR>
nnoremap <S-Up> :resize -4<CR>
nnoremap <S-Down> :resize +4<CR>

" escape
inoremap jk <ESC>


""" CUSTOM FUNCTIONS
" trim whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

" toggle wrap
"   Press ; to Toggle between Text Wrap and navigate wrapped lines with arrows
"   https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
"   nnoremap <silent> ; :call ChooseWrap()<CR>
nnoremap <silent> <leader><leader>ww :call ChooseWrap()<CR>
function ChooseWrap()
  let l:choice=confirm("Toggle Wrapping?", "&yes\n&no", 0)
  if l:choice==1
    if &wrap
      call DisableDisplayWrapping()
    else
      call EnableDisplayWrapping()
    endif
  endif
endfunction

function EnableDisplayWrapping()
  if !&wrap
    setlocal wrap
    " don't skip wrapped lines
    nnoremap <buffer> <Up> gk
    nnoremap <buffer> <Down> gj
    inoremap <buffer> <Up> <C-O>gk
    inoremap <buffer> <Down> <C-O>gj
    vnoremap <buffer> <Up> gk
    vnoremap <buffer> <Down> gj
  endif
endfunction

function DisableDisplayWrapping()
  if &wrap
    setlocal nowrap
    nunmap <buffer> <Up>
    nunmap <buffer> <Down>
    iunmap <buffer> <Up>
    iunmap <buffer> <Down>
    vunmap <buffer> <Up>
    vunmap <buffer> <Down>
  endif
endfunction


""" AUTO EXECUTE
" Remove trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
  " Don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
