""" Plugins

" re-init plugins
" call plug#begin('~/.config/nvim/plugged')
" call plug#end()

" load plugins
if filereadable(expand("~/.config/nvim/plug-manager.vim"))
  source ~/.config/nvim/plug-manager.vim
endif

""" ENVIRONMENT HOST
let g:node_host_prog    = expand('~/.nvm/versions/node/v10.15.3/bin/neovim-node-host')
let g:python_host_prog  = expand('/usr/local/bin/python')
let g:python3_host_prog = expand('/usr/local/bin/python3')
let g:ruby_host_prog    = expand('/usr/local/bin/neovim-ruby-host')


""" Aesthetics
syntax on
colorscheme onedark
highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none

" Opaque Background (Comment out to use terminal's profile)
set termguicolors

" Transparent Background (For i3 and compton)
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE


""" Other Configurations
set cursorline        " highlight current line
set path=**           " Allow VIm to go through all dir and sub dir
set mouse=a           " enable mouse support
set backspace=2       " make backspace work like most other apps
set ruler             " show the cursor position all the time
set showcmd           " display incomplete commands
set showmode          " display edit mode
set incsearch         " do incremental searching
set laststatus=2      " always display the status line
set history=1000      " sets how many lines of history VIM has to remember
set nowrap            " don't wrap long lines
set ignorecase        " /the would find 'the' or 'The', add \C if you want 'the' only
set smartcase         " while /The would find only 'The' etc.
set nopaste           " enable formatting while pasting
set pastetoggle=<F2>  " switch paste mode
set clipboard=unnamed " yank to and paste the selection without prepending "*
set autowrite         " save file before switching a buffer
set autoindent        " indent
set showmatch         " highlight matching brackets
set lazyredraw        " redraw only when we need to"
set hlsearch          " highlight same words while searching with Shift + *
set encoding=UTF-8    " set file encoding
set title             " show title
set fillchars+=vert:\

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
set number                " show
set numberwidth=5         " line numbers width
" set number relativenumber " hybrid relative number + absolute

" highlight trailing whitespaces
hi ExtraWhitespace ctermbg=172 guifg=#d78700
match ExtraWhitespace /\s\+$/

" automatically refresh changed files
set autoread

" recognizes filetype, plugins and indent
filetype plugin indent on

" Auto Completion
" Ctrl+x Ctrl+o to activate
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
          \	if &omnifunc == "" |
          \		set omnifunc=syntaxcomplete#Complete |
          \	endif
endif


" fold method definitions
" set foldenable        " enable folding
" set foldlevelstart=20 " open most folds by default
" set foldmethod=indent " fold based on indent level
" nnoremap fo za        " folding shortcut

" Turn Off Swap Files
set noswapfile nobackup nowb

" Completion
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

" Persistent Undo
" Keep undo history across sessions, by storing in file.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" open large files > 10 MB
let g:LargeFile = 10 * 1024 * 1024
augroup LargeFile
  " files with filesize too large are recognized too (getfsize = -2)
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END
function! LargeFile()
  set eventignore+=FileType " no syntax highlighting etc
  setlocal bufhidden=unload " save memory when other file is viewed
  setlocal undolevels=-1 " no undo possible
  setlocal foldmethod=manual
  setlocal noswapfile
endfunction

" show list of all filetypes
function! SortUnique(list, ...)
  let dictionary = {}
  for i in a:list
    let dictionary[string(i)] = i
  endfor
  if ( exists( 'a:1' ) )
    let result = sort( values( dictionary ), a:1 )
  else
    let result = sort( values( dictionary ) )
  endif
  return result
endfunction
command! Filetypes execute "echo
      \ join(
        \ SortUnique(
          \ map(
            \ split(
              \ globpath(&rtp, 'ftplugin/*.vim') . globpath(&rtp, 'syntax/*.vim'),
              \ '\n'),
            \ \"fnamemodify(v:val, ':t:r')\")),
        \'\n')"

" Neovim :Terminal
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert


""" Filetype-Specific Configurations

" HTML, XML, Jinja, Javascript, Typescript
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType js setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType ts setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>

" Markdown and Journal
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2

" XML
nnoremap fx :%!xmllint --format --encode UTF-8 -<CR>

" JSON
nnoremap fj :%! cat % \| ruby -e "require 'json'; puts JSON.pretty_generate(JSON.parse(STDIN.read))"<CR>

" Format and sort keys in JSON
nnoremap fsj :%! cat % \| ruby -e "
  \ require 'json';
  \ hash = JSON.parse(STDIN.read);
  \ def deep_sort(hash);
  \   hash.sort.map { \|(k, v)\|;
  \     case v;
  \     when Hash;
  \       [k, deep_sort(v)];
  \     when Array;
  \       [k, v.sort_by(&:to_s)];
  \     else;
  \       [k, v];
  \     end;
  \   }.to_h;
  \ end;
  \ puts JSON.pretty_generate(deep_sort(hash))"<CR><CR>


""" Custom Functions

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

" Dracula Mode (Dark)
function! ColorDracula()
    let g:airline_theme=''
    color dracula
    IndentLinesEnable
endfunction

" Seoul256 Mode (Dark & Light)
function! ColorSeoul256()
    let g:airline_theme='silver'
    color seoul256
    set wildmode=list:longest
    set wildmode=list:longest
    IndentLinesDisable
endfunction

" Forgotten Mode (Light)
function! ColorForgotten()
    " Light airline themes: tomorrow, silver, alduin
    " Light colors: forgotten-light, nemo-light
    let g:airline_theme='tomorrow'
    color forgotten-light
    IndentLinesDisable
endfunction

" Zazen Mode (Black & White)
function! ColorZazen()
    let g:airline_theme='badcat'
    color zazen
    IndentLinesEnable
endfunction


""" Custom Mappings

let mapleader=","
nmap <Leader>q :NERDTreeToggle %:p:h<CR>
nmap \ <leader>q
nmap <leader>w :TagbarToggle<CR>
nmap <leader>ee :Colors<CR>
nmap <leader>ea :AirlineTheme
nmap <leader>e1 :call ColorDracula()<CR>
nmap <leader>e2 :call ColorSeoul256()<CR>
nmap <leader>e3 :call ColorForgotten()<CR>
nmap <leader>e4 :call ColorZazen()<CR>
nmap <leader>im :TsuImport<CR>
nmap <leader>t :call TrimWhitespace()<CR>
xmap <leader>a gaip*
nmap <leader>a gaip*
nmap <leader>s <C-w>s<C-w>j:terminal<CR>
nmap <leader>vs <C-w>v<C-w>l:terminal<CR>
nmap <leader>d <Plug>(pydocstring)
nmap <leader>f :Files<CR>
nmap <leader>ff :Rg<CR>
nmap <leader>g :Goyo<CR>
nmap <leader>h :RainbowParentheses!!<CR>
nmap <leader>j :set filetype=journal<CR>
nmap <leader>k :ColorToggle<CR>
nmap <leader>l :Limelight!!<CR>
xmap <leader>l :Limelight!!<CR>
nmap <silent> <leader><leader> :noh<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" Find & Replace
nnoremap <leader>r :%s///g<Left><Left>
" nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<left><left>
" nnoremap <leader>rc :%s/\<<C-r><C-w>\>//gc<left><left><left>

" toggle line numbers
nnoremap <silent> <C-n><C-n> :set invnumber<CR>
nnoremap <silent> <C-m><C-m> :set invrelativenumber<CR>

" Escape
inoremap jj <ESC>

" move line up / down with Alt + j / k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv


""" Auto Execute

" Remove trailing whitespace on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


""" Toggle Wrap
" Press C to Toggle between Text Wrap and navigate wrapped lines with arrows
" https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap <silent> C :call ChooseWrap()<CR>
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

