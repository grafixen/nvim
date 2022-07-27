-- Make Ranger replace Netrw and be the file explorer
vim.g.rnvimr_enable_ex = 1

-- Make Ranger to be hidden after picking a file
vim.g.rnvimr_enable_picker = 1

-- Replace `$EDITOR` candidate with this command to open the selected file
vim.g.rnvimr_edit_cmd = "drop"

-- Disable a border for floating window
vim.g.rnvimr_draw_border = 0

-- Hide the files included in gitignore
vim.g.rnvimr_hide_gitignore = 1

-- Change the border's color
vim.g.rnvimr_border_attr = { fg = 14, bg = -1 }

-- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
vim.g.rnvimr_enable_bw = 1

-- Add a shadow window, value is equal to 100 will disable shadow
vim.g.rnvimr_shadow_winblend = 70

-- Draw border with both
vim.g.rnvimr_ranger_cmd = {'ranger', '--cmd=set draw_borders both'}

-- Map Rnvimr action
-- for more info: https://github.com/kevinhwang91/rnvimr/issues/79
vim.g.rnvimr_action = {
  ['gw'] = 'JumpNvimCwd',
  ['yw'] = 'EmitRangerCwd',
  ["<C-t>"] = 'NvimEdit tabedit',
  ["<C-x>"] = 'NvimEdit split',
  ["<C-v>"] = 'NvimEdit vsplit',
}

-- Add views for Ranger to adapt the size of floating window
vim.g.rnvimr_ranger_views = {
	{ minwidth = 90, ratio = {} },
	{ minwidth = 50, maxwidth = 89, ratio = { 1, 1 } },
	{ maxwidth = 49, ratio = { 1 } },
}

vim.api.nvim_set_keymap("n", "<A-e>", ":RnvimrToggle<CR>", { silent = true })
vim.api.nvim_set_keymap("t", "<A-e>", "<C-\\><C-n>:RnvimrToggle<CR>", { silent = true })

