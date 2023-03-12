return {
	tools = {
		executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
		reload_workspace_from_cargo_toml = true,
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			only_current_line = false,
			show_parameter_hints = true,
			parameter_hints_prefix = "<-",
			other_hints_prefix = "=>",
			max_len_align = false,
			max_len_align_padding = 1,
			right_align = false,
			right_align_padding = 7,
			highlight = "Comment",
		},
		hover_actions = {
			-- the border that is used for the hover window
			-- see vim.api.nvim_open_win()
			border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			},
			-- Maximal width of the hover window. Nil means no max.
			max_width = nil,
			-- Maximal height of the hover window. Nil means no max.
			max_height = nil,
			-- whether the hover action window gets automatically focused
			-- default: false
			auto_focus = false,
		},
		on_initialized = function()
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
				pattern = { "*.rs" },
				callback = function()
					local _, _ = pcall(vim.lsp.codelens.refresh)
				end,
			})
		end,
	},
	server = {
		on_attach = function(_, bufnr)
			local rt = require("rust-tools")
			-- Hover actions
			vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>la", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
		-- on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,

		settings = {
			["rust-analyzer"] = {
				lens = {
					enable = true,
				},
				checkOnSave = {
					enable = true,
					command = "clippy",
				},
			},
		},
	},
	-- debugging stuff
	dap = {
		adapter = {
			type = "executable",
			command = "lldb-vscode",
			name = "rt_lldb",
		},
	},
}
