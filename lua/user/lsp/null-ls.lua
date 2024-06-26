local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	sources = {
		-- CODE ACTION
		code_actions.eslint_d, -- Typescript

		-- FORMATTING
		formatting.fixjson, -- JSON
		formatting.goimports_reviser, -- Golang
		formatting.gofmt, -- Golang
		formatting.prettierd, -- Typescript
		formatting.black.with({ extra_args = { "--fast" } }), -- Python
		formatting.stylua, -- Lua

		-- DIAGNOSTICS
		diagnostics.revive, -- Go (linter)
		diagnostics.markdownlint, -- markdown
		diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
		}), -- Typescript
		diagnostics.write_good, -- English
		diagnostics.mypy.with({
			extra_args = function()
				local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
				return { "--python-executable", virtual .. "/bin/python3" }
			end,
		}), -- Python
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})
