local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	max_jobs = 9,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Default Utlities
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("andymass/vim-matchup")
	use("akinsho/toggleterm.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")
	use("nguyenvukhang/nvim-toggler")
	use("j-hui/fidget.nvim")

	-- Additional Utlities (Grafixen)
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
	})
	use("kylechui/nvim-surround")
	use("jeffkreeftmeijer/vim-numbertoggle")
	use("christoomey/vim-tmux-navigator")
	use("rcarriga/nvim-notify")
	use("RRethy/vim-illuminate")

	-- File Manager
	use("lmburns/lf.nvim")
	-- use("kyazdani42/nvim-web-devicons")
	-- use("kyazdani42/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")
	use("nvim-tree/nvim-tree.lua")
	use("matze/vim-move")

	-- Markup Languages
	use("alvan/vim-closetag")
	use("andreshazard/vim-freemarker")

	-- YAML
	use({
		"someone-stole-my-name/yaml-companion.nvim",
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("yaml_schema")
		end,
	})

	-- Colorschemes
	use("lunarvim/darkplus.nvim")
	use("marko-cerovac/material.nvim")
	use("ray-x/starry.nvim")

	-- CMP
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-emoji")
	-- CMP: AI
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
	})
	-- use({
	-- 	"zbirenbaum/copilot-cmp",
	-- 	after = { "copilot.lua" },
	-- 	config = function()
	-- 		require("copilot_cmp").setup({
	-- 			formatters = {
	-- 				insert_text = require("copilot_cmp.format").remove_existing,
	-- 			},
	-- 		})
	-- 	end,
	-- })

	-- Multi Cursor
	use({
		"mg979/vim-visual-multi",
		branch = "master",
	})

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		wants = { "friendly-snippets", "vim-snippets" },
	}) --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	-- use("honza/vim-snippets")

	-- Tabline
	use("akinsho/bufferline.nvim")

	-- ChatGPT
	use("MunifTanjim/nui.nvim")
	use("jackMort/ChatGPT.nvim")
	use("Bryley/neoai.nvim")

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("jose-elias-alvarez/typescript.nvim") -- utils for typescript
	use("onsails/lspkind.nvim")
	use("lvimuser/lsp-inlayhints.nvim")
	use("filipdutescu/renamer.nvim")
	use("ray-x/lsp_signature.nvim")
	use("b0o/SchemaStore.nvim")
	-- use({
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = { "VimEnter" },
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("user.copilot")
	-- 			-- require("copilot").setup({})
	-- 		end, 100)
	-- 	end,
	-- })

	-- Comments
	use("numToStr/Comment.nvim")
	use("folke/todo-comments.nvim")

	-- Debugging
	use("mfussenegger/nvim-dap")
	use("theHamsta/nvim-dap-virtual-text")
	use("rcarriga/nvim-dap-ui")

	--Golang
	use("ray-x/go.nvim")
	use("ray-x/guihua.lua") -- recommanded if need floating window support

	-- OrgMode
	use("nvim-orgmode/orgmode")
	use("akinsho/org-bullets.nvim")
	use("dkarter/bullets.vim")

	-- Project
	use("ahmedkhalf/project.nvim")
	use("windwp/nvim-spectre")

	-- QuickRun
	use("is0n/jaq-nvim")
	use({
		"michaelb/sniprun",
		run = "./install.sh",
	})

	-- Rust
	use("simrat39/rust-tools.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("windwp/nvim-ts-autotag")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/nvim-treesitter-refactor")
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- Graveyard
	-- use("p00f/nvim-ts-rainbow")
	-- use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	-- use("preservim/nerdcommenter") -- Commenting
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	-- use('jose-elias-alvarez/nvim-lsp-ts-utils') -- utils for typescript
	-- use("SirVer/ultisnips")
	-- use("quangnguyen30192/cmp-nvim-ultisnips")
	-- use({
	-- 	"folke/trouble.nvim",
	-- 	cmd = "TroubleToggle",
	-- })
	-- use("tpope/vim-surround")
	-- use({
	-- 	"neoclide/coc.nvim",
	-- 	branch = "release",
	-- })
	-- use({
	-- 	"kevinhwang91/rnvimr",
	-- 	run = "make sync",
	-- })
	-- use({
	-- 	"abecodes/tabout.nvim",
	-- 	wants = { "nvim-treesitter" }, -- or require if not used so far
	-- })
	-- use("github/copilot.vim")
	-- use({ "CRAG666/code_runner.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
