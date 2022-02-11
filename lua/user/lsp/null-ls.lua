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

null_ls.setup({
	debug = false,
	sources = {
		-- JavaScript, TypeScript
		-- Prettier File Format (Alternative: Activate CoC => c.f. init.lua)
		-- formatting.prettier_d_slim.with({
  --     extra_filetypes = { "toml", "solidity" },
  --     extra_args = { "--semi", "--single-quote", "--jsx-single-quote" } }
  --   ),

    -- eslint
    diagnostics.eslint_d,
    code_actions.eslint_d,

		-- Python
		formatting.black.with({ extra_args = { "--fast" } }),
		-- diagnostics.flake8

		-- LUA
		-- formatting.stylua,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
