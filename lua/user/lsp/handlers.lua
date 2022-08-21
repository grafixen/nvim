local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
	local icons = require("user.icons")
	local signs = {

		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_lines = false,
		virtual_text = false,
		-- virtual_text = {
		--   -- spacing = 7,
		--   -- update_in_insert = false,
		--   -- severity_sort = true,
		--   -- prefix = "<-",
		--   prefix = " ●",
		--   source = "if_many", -- Or "always"
		--   -- format = function(diag)
		--   --   return diag.message .. "blah"
		--   -- end,
		-- },

		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			-- border = {"▄","▄","▄","█","▀","▀","▀","█"},
			source = "if_many", -- Or "always"
			header = "",
			prefix = "",
			-- width = 40,
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
		-- width = 60,
		-- height = 30,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		-- width = 60,
		-- height = 30,
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true,
	})
end

local function buf_map(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		noremap = true,
		silent = true,
	})
end

local function lsp_highlight_document(client)
	-- if client.server_capabilities.document_highlight then
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
	-- end
end

local function lsp_commands()
	vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
	vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
	vim.cmd("command! LspFormat lua vim.lsp.buf.format()")
	vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
	vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
	vim.cmd('command! LspQuickfix lua vim.lsp.buf.code_action({ only = {"quickfix"}, })')
	vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
	vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
	vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
	vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
	vim.cmd('command! LspDiagPrev lua vim.diagnostic.goto_prev({ border = "rounded" })')
	vim.cmd('command! LspDiagNext lua vim.diagnostic.goto_next({ border = "rounded" })')
	vim.cmd('command! LspDiagLine lua vim.diagnostic.open_float({ border = "rounded" })')
	vim.cmd("command! LspDiagnostics Telescope diagnostics")
	vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
end

local function lsp_keymaps(bufnr)
	-- Definitions
	buf_map(bufnr, "n", "gD", ":LspDeclaration<CR>")
	buf_map(bufnr, "n", "gd", ":LspDef<CR>")
	-- Information
	buf_map(bufnr, "n", "K", ":LspHover<CR>")
	buf_map(bufnr, "n", "<C-k>", ":LspSignatureHelp<CR>")
	buf_map(bufnr, "n", "gi", ":LspImplementation<CR>")
	buf_map(bufnr, "n", "gr", ":LspRefs<CR>")
	-- Diagnostics
	buf_map(bufnr, "n", "do", ":LspDiagLine<CR>")
	buf_map(bufnr, "n", "dj", ":LspDiagNext<CR>")
	buf_map(bufnr, "n", "dk", ":LspDiagPrev<CR>")
	buf_map(bufnr, "n", "gl", ":Telescope diagnostics<CR>")
	buf_map(bufnr, "n", "gL", ":lua vim.diagnostic.setloclist()<CR>")
	buf_map(bufnr, "n", "gq", ":LspQuickfix<CR>")
	-- Actions
	buf_map(bufnr, "n", "<M-f>", ":LspFormat<CR>")
	buf_map(bufnr, "n", "<M-a>", ":LspCodeAction<CR>")
	buf_map(bufnr, "n", "<M-r>", ":LspRename<CR>")
end

M.on_attach = function(client, bufnr)
	lsp_commands()
	lsp_keymaps(bufnr)
	-- lsp_highlight_document(client)
end

return M
