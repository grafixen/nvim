local M = {}

-- TODO: backfill this to template
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    noremap = true, silent = true,
  })
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function lsp_commands()
  vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev({ border = \"rounded\" })")
  vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next({ border = \"rounded\" })")
  vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float({ border = \"rounded\" })")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

	vim.cmd("command! Format lua vim.lsp.buf.formatting()")
end

local function lsp_keymaps(bufnr)
	buf_map(bufnr, "n", "gD", ":LspDeclaration<CR>")
	buf_map(bufnr, "n", "gd", ":LspDef<CR>")
	buf_map(bufnr, "n", "K", ":LspHover<CR>")
	buf_map(bufnr, "n", "gi", ":LspImplementation<CR>")
	buf_map(bufnr, "n", "<C-k>", ":LspSignatureHelp<CR>")
	buf_map(bufnr, "n", "gr", ":LspRefs<CR>")
  buf_map(bufnr, "n", "<leader>gn", ":LspRename<CR>")
	buf_map(bufnr, "n", "<leader>ga", ":LspCodeAction<CR>")
	buf_map(bufnr, "n", "<leader>gl", ":LspDiagLine<CR>")
  buf_map( bufnr, "n", "gl", ":LspDiagLine<CR>")
	buf_map(bufnr, "n", "[d", ":LspDiagPrev<CR>")
  buf_map(bufnr, "n", "]d", ":LspDiagNext<CR>")
	buf_map(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)

    -- buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
    -- buf_map(bufnr, "n", "gr", ":TSLspRenameFile<CR>")
    -- buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
	end

	lsp_commands()
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
