let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags/')

command! -nargs=0 GutentagsClearCache
  \ call system('rm ' . g:gutentags_cache_dir . '/*')
