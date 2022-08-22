local M = {}

M.on_attach = function(client, bufnr)
	require("lsp-inlayhints").on_attach(bufnr, client)
end

M.settings = {
	gopls = {
		hints = {
			assignVariableTypes = true,
			compositeLiteralFields = true,
			compositeLiteralTypes = true,
			constantValues = true,
			functionTypeParameters = true,
			parameterNames = true,
			rangeVariableTypes = true,
		},
	},
}

return M
