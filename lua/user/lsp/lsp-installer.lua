local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
	"angularls",
	"cssls",
	"emmet_ls",
	"eslint",
	"graphql",
	"html",
	"jsonls",
	"pyright",
	"tailwindcss",
	"tsserver",
	"yamlls",
}

local settings = {
	ensure_installed = servers,
	-- automatic_installation = false,
	ui = {
		icons = {
			-- server_installed = "◍",
			-- server_pending = "◍",
			-- server_uninstalled = "◍",
			-- server_installed = "✓",
			-- server_pending = "➜",
			-- server_uninstalled = "✗",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
		},
	},

	log_level = vim.log.levels.INFO,
	-- max_concurrent_installers = 4,
	-- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
}

lsp_installer.setup(settings)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}
for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server == "emmet_ls" then
		local emmet_ls_opts = require("user.lsp.settings.emmet_ls")
		opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end

	if server == "jsonls" then
		local jsonls_opts = require("user.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "tsserver" then
		local tsserver_opts = require("user.lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

	lspconfig[server].setup(opts)
end
