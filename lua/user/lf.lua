-- This feature will not work if the plugin is lazy-loaded
vim.g.lf_netrw = 1

local status_ok, lf = pcall(require, "lf")
if not status_ok then
	return
end

lf.setup({
	default_cmd = "lf", -- default `lf` command
	default_action = "edit", -- default action when `Lf` opens a file
	default_actions = { -- default action keybindings
		["<C-t>"] = "tabedit",
		["<C-s>"] = "split",
		["<C-v>"] = "vsplit",
		["<C-o>"] = "tab drop",
	},

	winblend = 10, -- psuedotransparency level
	dir = "", -- directory where `lf` starts ('gwd' is git-working-directory, "" is CWD)
	direction = "float", -- window type: float horizontal vertical
	border = "double", -- border kind: single double shadow curved
	height = 0.80, -- height of the *floating* window
	width = 0.85, -- width of the *floating* window
	escape_quit = true, -- map escape to the quit command (so it doesn't go into a meta normal mode)
	focus_on_open = false, -- focus the current file when opening Lf (experimental)
	mappings = true, -- whether terminal buffer mapping is enabled
	tmux = false, -- tmux statusline can be disabled on opening of Lf
})

vim.api.nvim_set_keymap("n", "<A-e>", "<cmd>lua require('lf').start()<CR>", { noremap = true })
