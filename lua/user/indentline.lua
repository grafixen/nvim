local ibl_status_ok, ibl = pcall(require, "ibl")
if not ibl_status_ok then
	return
end

local ibl_hooks_status_ok, hooks = pcall(require, "ibl.hooks")
if not ibl_hooks_status_ok then
	return
end

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "space:"
-- vim.opt.listchars:append "eol:↴"

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:¶")
-- vim.opt.listchars:append("tab:|⇢")
-- vim.opt.listchars:append("trail:·")
-- vim.opt.listchars:append("extends:>")
-- vim.opt.listchars:append("precedes:<")

ibl.setup({
	-- show_current_context = true,
	-- space_char_blankline = " ",
	indent = {
		char = "▎",
		tab_char = "▎",
		highlight = highlight,
	},
	whitespace = {
		remove_blankline_trail = true,
	},
	scope = {
		enabled = true,
		char = "▎",
		show_start = true,
		show_end = false,
		injected_languages = true,
		priority = 1024,
		include = {
			node_type = {
				["*"] = {
					"^argument",
					"^expression",
					"^for",
					"^if",
					"^import",
					"^type",
					"arguments",
					"block",
					"block_mapping_pair",
					"bracket",
					"declaration",
					"field",
					"func_literal",
					"function",
					"import_spec_list",
					"list",
					"return_statement",
					"short_var_declaration",
					"statement",
					"switch_body",
					"try",
					--
					"^object",
					"^table",
					"^while",
					"class",
					"catch_clause",
					"else_clause",
					"jsx_element",
					"jsx_self_closing_element",
					"method",
					"operation_type",
					"try_statement",
				},
			},
		},
	},
	exclude = {
		buftypes = {
			"terminal",
			"nofile",
		},
		filetypes = {
			"help",
			"startify",
			"dashboard",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
		},
	},
})
