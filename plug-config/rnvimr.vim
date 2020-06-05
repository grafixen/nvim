let g:rnvimr_ex_enable = 1
let g:rnvimr_draw_border = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_bw_enable = 1

let g:rnvimr_action = {
\ '<C-t>': 'NvimEdit tabedit',
\ '<C-x>': 'NvimEdit split',
\ '<C-v>': 'NvimEdit vsplit',
\ 'gw': 'JumpNvimCwd',
\ 'yw': 'EmitRangerCwd'
\ }

let g:rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"
            \ --cmd="set draw_borders both"'
let g:rnvimr_presets = [
            \ {'width': 0.800, 'height': 0.800}]
highlight link RnvimrNormal CursorLine
