local ts_status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not ts_status_ok then
	return
end

local cmt_status_ok, ts_cmt_configs = pcall(require, "ts_context_commentstring")
if not cmt_status_ok then
	return
end

ts_configs.setup({
	ensure_installed = "all", --  one of "all" or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = { enable = true },
	matchup = { enable = true },
	indent = { enable = true, disable = { "yaml" } },
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
	-- context_commentstring = {
	-- 	enable = true,
	-- 	enable_autocmd = false,
	-- 	-- For more config info: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	-- 	config = {
	-- 		javascript = {
	-- 			__default = "// %s",
	-- 			jsx_element = "{/* %s */}",
	-- 			jsx_fragment = "{/* %s */}",
	-- 			jsx_attribute = "// %s",
	-- 			comment = "// %s",
	-- 		},
	-- 		typescript = { __default = "// %s", __multiline = "/* %s */" },
	-- 	},
	-- },
	autotag = {
		enable = true,
		disable = { "xml", "markdown" },
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,
		persist_queries = false,
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters
		max_file_lines = 1000,
		colors = {
			-- "#68a0b0",
			-- "#946EaD",
			-- "#c7aA6D",
			"Gold",
			"Orchid",
			"DodgerBlue",
			-- "Cornsilk",
			-- "Salmon",
			-- "LawnGreen",
		},
		disable = { "html" },
	},
	refactor = {
		smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
		highlight_definitions = { enable = true },
		-- navigation = {
		-- 	enable = true,
		-- 	keymaps = {
		-- 		goto_definition_lsp_fallback = "gnd",
		-- 		-- use telescope for these lists
		-- 		-- list_definitions = "gnD",
		-- 		-- list_definitions_toc = "gO",
		-- 		-- @TODOUA: figure out if I need both below
		-- 		goto_next_usage = "<a-*>", -- is this redundant?
		-- 		goto_previous_usage = "<a-#>", -- also this one?
		-- 	},
		-- },
		-- highlight_current_scope = { enable = true },
	},
	textobjects = {
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["df"] = "@function.outer",
				["dF"] = "@class.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@call.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@call.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@call.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@call.outer",
			},
		},
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["at"] = "@class.outer",
				["it"] = "@class.inner",
				["ac"] = "@call.outer",
				["ic"] = "@call.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["a/"] = "@comment.outer",
				["i/"] = "@comment.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["as"] = "@statement.outer",
				["is"] = "@scopename.inner",
				["aA"] = "@attribute.outer",
				["iA"] = "@attribute.inner",
				["aF"] = "@frame.outer",
				["iF"] = "@frame.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				[",a"] = "@parameter.inner",
			},
			swap_previous = {
				[",A"] = "@parameter.inner",
			},
		},
	},
})

ts_cmt_configs.setup({
	enable_autocmd = false,
	languages = {
		javascript = {
			__default = "// %s",
			jsx_element = "{/* %s */}",
			jsx_fragment = "{/* %s */}",
			jsx_attribute = "// %s",
			comment = "// %s",
		},
		typescript = { __default = "// %s", __multiline = "/* %s */" },
	},
})
