-- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils

-- local function organize_imports()
--   local params = {
--     command = '_typescript.organizeImports',
--     arguments = { vim.api.nvim_buf_get_name(0) },
--     title = '',
--   }
--   vim.lsp.buf.execute_command(params)
-- end

return {
  -- OrganizeImports = {
  --   organize_imports,
  --   description = 'Organize Imports',
  -- },
  --
  -- init_options = require("nvim-lsp-ts-utils").init_options,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  },
}

