local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
	return
end

illuminate.configure({
	-- providers: provider used to get references in the buffer, ordered by priority
	providers = {
		"lsp",
		"treesitter",
		"regex",
	},
	-- delay: delay in milliseconds
	delay = 100,
	-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
	filetypes_denylist = {
		"dirvish",
		"fugitive",
		"alpha",
		"NvimTree",
		"DressingSelect",
		"harpoon",
	},
	-- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
	filetypes_allowlist = {},
	-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
	modes_denylist = {},
	-- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
	modes_allowlist = {},
	-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
	-- Only applies to the 'regex' provider
	-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
	providers_regex_syntax_denylist = {},
	-- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
	-- Only applies to the 'regex' provider
	-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
	providers_regex_syntax_allowlist = {},
	-- under_cursor: whether or not to illuminate under the cursor
	under_cursor = true,
})

-- vim.g.Illuminate_delay = 0
-- vim.g.Illuminate_highlightUnderCursor = 0
-- vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree", "DressingSelect", "harpoon" }
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.api.nvim_set_keymap("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<a-p>",
	'<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
	{ noremap = true }
)
