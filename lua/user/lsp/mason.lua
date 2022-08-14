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
	-- "eslint", => Use Null-ls instead
	"graphql",
	"html",
	"jsonls",
	"pyright",
  "sumneko_lua",
	"tailwindcss",
  -- "tsserver", => Use Typescript Initializer instead c.f. typescript.setup(...)
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

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "tailwindcss" then
    local tailwindcss_opts = require "user.lsp.settings.tailwindcss"
    opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
  end

  if server == "yamlls" then
    local yamlls_opts = require "user.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  lspconfig[server].setup(opts)
  ::continue::
end
