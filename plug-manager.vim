""" PLUGINS
" Brief help
" :PlugInstall [name ...] [#thread]   - installs plugins
" :PlugUpdate [name ...] [#thread]    - Install or update plugins
" :PlugClean[!]                       - Remove unlisted plugins (bang version will clean without prompt)
" :PlugUpgrade                        - Upgrade vim-plug itself
" :PlugStatus                         - Check the status of plugins
" :PlugDiff                           - Examine changes from the previous update and the pending changes
" :PlugSnapshot[!] [output path]      - Generate script for restoring the current snapshot of the plugins

call plug#begin('~/.config/nvim/plugged')

" Aesthetics - Main
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'

" Aethetics - Additional
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nightsense/forgotten'
Plug 'nightsense/nemo'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-journal'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'rhysd/vim-color-spring-night'
Plug 'vim-airline/vim-airline-themes'
Plug 'whatyouhide/vim-gotham'
Plug 'yuttie/hydrangea-vim'
Plug 'zaki/zazen'

" Functionalities
Plug 'christoomey/vim-tmux-navigator'
Plug 'heavenshell/vim-pydocstring'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/vim-journal'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-sensible'

" Coding
Plug 'alvan/vim-closetag'
Plug 'chrisbra/Colorizer'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-grepper'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/loremipsum'

" CoC
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Ecmascript
Plug 'heavenshell/vim-jsdoc'

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

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'ternjs/tern_for_vim', { 'do': 'yarn install && yarn global add tern' }

" Linting
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'

" Markdown
Plug 'dkarter/bullets.vim'
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'plasticboy/vim-markdown'

" Multiple Cursors
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

" Ranger File Manager
Plug 'rafaqz/ranger.vim'

" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" Table Mode
Plug 'dhruvasagar/vim-table-mode'

" Tags
Plug 'liuchengxu/vista.vim'

" Typescript
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Quramy/tsuquyomi', { 'do': 'yarn global add typescript' }
Plug 'leafgarland/typescript-vim'

call plug#end()


""" PLUGIN CONFIGURATION
" Ale
if !hlexists('ALEVirtualTextError')
  highlight link ALEVirtualTextError ErrorMsg
  highlight link ALEVirtualTextWarning SpecialChar
endif

let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '  ---> '
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 100
let g:ale_sign_column_always = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_echo_msg_format = '[%linter% %code%] %s'

let g:ale_fix_on_save = 1
let g:ale_open_list = 0             " Don't open the loclist when reading a file (if there are errors)
let g:ale_linters_explicit = 1      " Only run linters named in ale_linters settings.

let b:ale_linters = ['flow-language-server'] " Enables only Flow for JavaScript (https://www.flow.org/)
let g:ale_linters = {
\ 'javascript': ['eslint', 'flow-language-server'],
\ 'typescript': ['eslint', 'tsserver', 'typecheck'],
\}
let g:ale_fixers = {
\ 'css': ['prettier'],
\ 'javascript': ['prettier', 'eslint'],
\ 'typescript': ['prettier', 'eslint'],
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

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

" Bullets
let g:bullets_enabled_file_types = [
\ 'markdown',
\ 'text',
\ 'gitcommit',
\ 'scratch'
\ ]

" CoC
" Make sure NODE can be called by Coc else extensions will not be called
" :CocInfo
let g:coc_node_path = substitute(system('which node'), '\n', '', '')
let g:coc_global_extensions = [
\ 'coc-angular',
\ 'coc-css',
\ 'coc-emmet',
\ 'coc-eslint',
\ 'coc-highlight',
\ 'coc-json',
\ 'coc-html',
\ 'coc-lists',
\ 'coc-marketplace',
\ 'coc-prettier',
\ 'coc-snippets',
\ 'coc-tabnine',
\ 'coc-tslint-plugin',
\ 'coc-tsserver',
\ 'coc-yank'
\ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Navigate snippet placeholders using tab
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
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

" Custom statusline
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

" RipGrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Activate FZF Statusline
autocmd! User FzfStatusLine call <SID>fzf_statusline()

" Git Gutter
let g:gitgutter_enabled                 = 1
let g:gitgutter_max_signs               = 500 " default value
let g:gitgutter_sign_added              = '+'
let g:gitgutter_sign_modified           = '%'
let g:gitgutter_sign_removed            = 'x'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed   = '~'

" Grep
let g:grepper={}
let g:grepper.tools=["rg"]

" IndentLine
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#363949'

" Javasript
let g:javascript_plugin_flow = 1

" Markdown
set conceallevel=2
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 1
let g:mkdp_markdown_css = ''
let g:mkdp_preview_options = {
\ 'mkit': {},
\ 'katex': {},
\ 'uml': {},
\ 'maid': {},
\ 'disable_sync_scroll': 0,
\ 'sync_scroll_type': 'middle',
\ 'hide_yaml_meta': 1,
\ 'sequence_diagrams': {}
\ }

" NERDCommenter
" !!! See link for more config options: https://github.com/scrooloose/nerdcommenter !!!
let g:NERDSpaceDelims            = 1      " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs        = 1      " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign           = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines      = 1      " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1      " Enable trimming of trailing whitespace when uncommenting

" Startify
let g:startify_change_to_vcs_root = 1
let g:startify_change_to_dir = 1
let g:startify_bookmarks = [
\ { 'c': '~/.config/nvim/init.vim' },
\ { 'd': '~/.config/nvim/plug-manager.vim' },
\ { 'e': '~/.zshrc' }
\ ]

" Tern
let g:tern_request_timeout = 6000
let g:tern#command         = ['tern']
let g:tern#arguments       = ['--persistent']

" Tsuquyomi
let g:tsuquyomi_javascript_support   = 1
let g:tsuquyomi_auto_open            = 1
let g:tsuquyomi_disable_quickfix     = 1
let g:tsuquyomi_shortest_import_path = 1
let g:tsuquyomi_single_quote_import  = 1

" Vista
set statusline+=%{NearestMethodOrFunction()}
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" Show the nearest method/function in the statusline
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" Ultisnips
let g:UltiSnipsExpandTrigger       = "<C-Space>"
let g:UltiSnipsJumpForwardTrigger  = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" WebDevIcons
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_startify = 1
