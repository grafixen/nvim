local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
  return
end

local typescipt_ok, typescript = pcall(require, "typescript")
if not typescipt_ok then
  return
end

local servers = {
	"angularls",
	"cssls",
  "dockerls",
	"emmet_ls",
  "gopls",
	"graphql",
	"html",
	"jsonls",
	"pyright",
  -- TODO: rewrite LUA_LS: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/lua_ls.lua
  "lua_ls",
  "rust_analyzer",
	"tailwindcss",
  -- "tsserver", -- Use Typescript Initializer instead c.f. typescript.setup(...)
	"yamlls",
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
    keymaps = {
			-- Keymap to expand a package
			toggle_package_expand = "<CR>",
			-- Keymap to install the package under the current cursor position
			install_package = "i",
			-- Keymap to reinstall/update the package under the current cursor position
			update_package = "u",
			-- Keymap to check for new version for the package under the current cursor position
			check_package_version = "c",
			-- Keymap to update all installed packages
			update_all_packages = "U",
			-- Keymap to check which installed packages are outdated
			check_outdated_packages = "C",
			-- Keymap to uninstall a package
			uninstall_package = "X",
			-- Keymap to cancel a package installation
			cancel_installation = "<C-c>",
			-- Keymap to apply language filter
			apply_language_filter = "<C-f>",
		},
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
if typescipt_ok then
  typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    -- LSP Config options
    server = {
      handlers = require("user.lsp.handlers"),
      capabilities = require("user.lsp.settings.tsserver").capabilities,
      on_attach = require("user.lsp.settings.tsserver").on_attach,
      settings = require("user.lsp.settings.tsserver").settings,
    },
  })
end

local opts = {}
for _, server in pairs(servers) do

  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "gopls" then
    local gopls_opts = require "user.lsp.settings.gopls"
    opts = vim.tbl_deep_extend("force", gopls_opts, opts)
  end

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "lua_ls" then
    local lua_ls_opts = require "user.lsp.settings.lua_ls"
    opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
  end

  if server == "tailwindcss" then
    local tailwindcss_opts = require "user.lsp.settings.tailwindcss"
    opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
  end

  if server == "rust_analyzer" then
    local rust_opts = require "user.lsp.settings.rust"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup(rust_opts)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
