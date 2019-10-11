" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes
" Aesthetics - Main
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim'
Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-journal'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'nightsense/forgotten'
Plug 'whatyouhide/vim-gotham'
Plug 'zaki/zazen'

" Aethetics - Additional
Plug 'nightsense/nemo'
Plug 'yuttie/hydrangea-vim'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'rhysd/vim-color-spring-night'

" Functionalities
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-abolish'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'chrisbra/Colorizer'
Plug 'heavenshell/vim-pydocstring'
Plug 'vim-scripts/loremipsum'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dkarter/bullets.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" FZF: Homebrew installation
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Emmet
Plug 'mattn/emmet-vim'

" Ecmascript
Plug 'heavenshell/vim-jsdoc'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs'
Plug 'dense-analysis/ale'

" Typescript
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Quramy/tsuquyomi', { 'do': 'npm install -g typescript' }
Plug 'leafgarland/typescript-vim'

" Initialize plugin system
call plug#end()

" Brief help
" :PlugInstall [name ...] [#thread]   - installs plugins
" :PlugUpdate [name ...] [#thread]    - Install or update plugins
" :PlugClean[!]                       - Remove unlisted plugins (bang version will clean without prompt)
" :PlugUpgrade                        - Upgrade vim-plug itself
" :PlugStatus                         - Check the status of plugins
" :PlugDiff                           - Examine changes from the previous update and the pending changes
" :PlugSnapshot[!] [output path]      - Generate script for restoring the current snapshot of the plugins

 """ Plugin Configurations

" WebDevIcons
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'

" NERDTree Tab Navigation
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-t> :tabnew<CR>

" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_javascript = 1
let g:NERDAltDelims_typescript = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {
\ 'javascript': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' },
\ 'typescript': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Emmet
" Tips & Tricks: https://medium.com/vim-drops/be-a-html-ninja-with-emmet-for-vim-feee15447ef1
let g:user_emmet_leader_key=','

" ALE
let g:ale_linters = {
\ 'elixir': ['mix_format'],
\ 'javascript': ['prettier', 'eslint'],
\ 'typescript': ['tslint'],
\ 'sql': ['sqlint'],
\ '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_linters_explicit = 1    " Only run linters named in ale_linters settings.
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

" Airline
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''

" make Airline look like powerline
" https://github.com/vim-airline/vim-airline/wiki/FAQ
" let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
" let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
" check url below for separation glyph codes
" https://github.com/ryanoasis/powerline-extra-symbols
let g:airline_left_sep = '▶'
let g:airline_left_sep = '»'
let g:airline_right_sep = '◀'
let g:airline_right_sep = '«'
" overrides above searators
let g:airline_left_sep = "\uE0C4"
let g:airline_left_sep = "\uE0C6"
let g:airline_right_sep = "\uE0C5"
let g:airline_right_sep = "\uE0C7"

let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.readonly = ''
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = ''

" airline extensions
let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
let g:airline#extensions#readonly#symbol   = '⊘'
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

" Tern
" https://github.com/carlitux/deoplete-ternjs
let g:tern_request_timeout = 6000
let g:deoplete#sources#ternjs#filetypes = [
\ 'jsx',
\ 'javascript',
\ 'javascript.jsx',
\ ]

let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#include_keywords = 1

let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:deoplete#sources#tss#javascript_support = 1

" Tsuquyomi
let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_auto_open = 1
let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_shortest_import_path = 1

" Git Gutter
set updatetime=200
let g:gitgutter_enabled = 1
let g:gitgutter_max_signs = 500  " default value
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '%'
let g:gitgutter_sign_removed = 'x'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '~'

" Supertab
let g:SuperTabDefaultCompletionType = "<C-n>"

" Ultisnips
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-x>"

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#363949'

" TagBar
let g:tagbar_width = 30
let g:tagbar_iconchars = ['↠', '↡']

" CTag typescript support
" https://github.com/majutsushi/tagbar/wiki#typescript
" https://github.com/jb55/typescript-ctags/blob/master/.ctags
let g:tagbar_type_typescript = {
\ 'ctagsbin' : 'tstags',
\ 'ctagsargs' : '-f-',
\ 'kinds': [
  \ 'e:enums:0:1',
  \ 'f:function:0:1',
  \ 't:typealias:0:1',
  \ 'M:Module:0:1',
  \ 'I:import:0:1',
  \ 'i:interface:0:1',
  \ 'C:class:0:1',
  \ 'm:method:0:1',
  \ 'p:property:0:1',
  \ 'v:variable:0:1',
  \ 'c:const:0:1',
\ ],
\ 'sort' : 0
\ }


" fzf-vim
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
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Custom statusline
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()


" Multiple Cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<Down>' " <Down> is equivalent to <Alt+Arrow Down>
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key             ='<C-c>'
nnoremap <C-c> :call multiple_cursors#quit()<CR>

" Lime Light
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Bullets.vim
let g:bullets_enabled_file_types = [
\ 'markdown',
\ 'text',
\ 'gitcommit',
\ 'scratch'
\ ]
