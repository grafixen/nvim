call plug#begin('~/.config/nvim/plugged')

" Aesthetics - Main
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'

" Aethetics - Additional
Plug 'crusoexia/vim-monokai'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lifepillar/vim-solarized8'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline-themes'

" Functionalities
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mhinz/vim-grepper'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'

" Coding
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'

" CoC
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Emmet
Plug 'mattn/emmet-vim'

" FZF
if has('macunix')
  " Use existing Brew Install
  Plug '/usr/local/opt/fzf'
else
  " Use Manual Install
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'junegunn/fzf.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Linting
Plug 'sheerun/vim-polyglot'

" Multiple Cursors
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

" Python
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'Vimjas/vim-python-pep8-indent'

" Quickscope
Plug 'unblevable/quick-scope'

" Ranger File Manager
Plug 'kevinhwang91/rnvimr', { 'do': 'make sync' }

" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" Table Mode
Plug 'dhruvasagar/vim-table-mode'

" Vista
Plug 'liuchengxu/vista.vim'

call plug#end()


""" PLUGIN CONFIGURATION
" Airline
let g:airline_theme = 'murmur'
let g:airline_powerline_fonts = 1

" Airline: tabline
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 1       " enables tab numbers
let g:airline#extensions#tabline#tab_nr_type = 1       " shows correct tab numbers
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.crypt      = '🔒'
let g:airline_symbols.linenr     = '␊'
let g:airline_symbols.linenr     = '␤'
let g:airline_symbols.linenr     = '¶'
let g:airline_symbols.branch     = '⎇'
let g:airline_symbols.paste      = 'ρ'
let g:airline_symbols.paste      = 'Þ'
let g:airline_symbols.paste      = '∥'
let g:airline_symbols.readonly   = ''
let g:airline_symbols.spell      = 'Ꞩ'
let g:airline_symbols.notexists  = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly   = ''

" Airline: extensions
let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
let g:airline#extensions#readonly#symbol   = '⊘'
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'

" Airline: coc formatting
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Airline: configure error/warning section to use coc.nvim
let g:airline_section_error   = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" CoC
" Make sure NODE can be called by Coc else extensions will not be called
" :CocInfo
let g:coc_node_path = substitute(system('which node'), '\n', '', '')
let g:coc_global_extensions = [
\ 'coc-angular',
\ 'coc-highlight',
\ 'coc-html',
\ 'coc-eslint',
\ 'coc-pairs',
\ 'coc-prettier',
\ 'coc-python',
\ 'coc-tabnine',
\ 'coc-tsserver',
\ 'coc-ultisnips'
\ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gf <Plug>(coc-fix-current)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" instead of having ~/.vim/coc-settings.json
let s:LSP_CONFIG = {
\  'flow': {
\    'command': exepath('flow'),
\    'args': ['lsp'],
\    'filetypes': ['javascript', 'javascriptreact'],
\    'initializationOptions': {},
\    'requireRootPattern': 1,
\    'settings': {},
\    'rootPatterns': ['.flowconfig']
\  }
\}

let s:languageservers = {}
for [lsp, config] in items(s:LSP_CONFIG)
  let s:not_empty_cmd = !empty(get(config, 'command'))
  if s:not_empty_cmd | let s:languageservers[lsp] = config | endif
endfor

if !empty(s:languageservers)
  call coc#config('languageserver', s:languageservers)
endif

" Color changes
hi! link CocErrorSign WarningMsg
hi! link CocWarningSign Number
hi! link CocInfoSign Type

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Emmet
"  Tips & Tricks: https://medium.com/vim-drops/be-a-html-ninja-with-emmet-for-vim-feee15447ef1
let g:user_emmet_leader_key=','

" FZF
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
\ 'ctrl-v': 'vsplit' }
let g:fzf_colors = {
\ 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'Type'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Character'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment'] }
let g:fzf_history_dir = '~/.local/share/fzf-history'

""" Custom statusline
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

""" Activate FZF Statusline
autocmd! User FzfStatusLine call <SID>fzf_statusline()

""" RipGrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


" Git Gutter
let g:gitgutter_enabled                 = 1
let g:gitgutter_max_signs               = 500 " default value
let g:gitgutter_sign_added              = '+'
let g:gitgutter_sign_modified           = '%'
let g:gitgutter_sign_removed            = 'x'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed   = '~'

" IndentLine
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#363949'

" NERDCommenter
" !!! See link for more config options: https://github.com/scrooloose/nerdcommenter !!!
let g:NERDSpaceDelims            = 1      " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs        = 1      " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign           = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines      = 1      " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1      " Enable trimming of trailing whitespace when uncommenting

" RnvimR
let g:rnvimr_ex_enable = 1
let g:rnvimr_draw_border = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_bw_enable = 1

let g:rnvimr_action = {
\ '<C-t>': 'NvimEdit tabedit',
\ '<C-s>': 'NvimEdit split',
\ '<C-v>': 'NvimEdit vsplit',
\ 'gw': 'JumpNvimCwd',
\ 'yw': 'EmitRangerCwd'
\ }

let g:rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"
            \ --cmd="set draw_borders both"'
let g:rnvimr_presets = [
            \ {'width': 0.800, 'height': 0.800}]
highlight link RnvimrNormal CursorLine

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Startify
let g:startify_change_to_vcs_root = 1
let g:startify_change_to_dir = 1
let g:startify_session_dir = '~/.config/nvim/sessions'

let g:startify_lists = [
\ { 'type': 'files',      'header': ['Files'] },
\ { 'type': 'dir',        'header': ['Current Directory', getcwd()] },
\ { 'type': 'sessions',   'header': ['Sessions'] },
\ { 'type': 'bookmarks',  'header': ['Bookmarks'] },
\ ]

let g:startify_bookmarks = [
\ { 'c': '~/.config/nvim/init.vim' },
\ { 'd': '~/.config/nvim/plug-manager.vim' },
\ { 'e': '~/.zshrc' }
\ ]

" Ultisnips
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsListSnippets        = "<c-l>"
let g:UltiSnipsJumpForwardTrigger  = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" WebDevIcons
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_startify = 1
