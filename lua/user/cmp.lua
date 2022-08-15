local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- local check_backspace = function()
--   local col = vim.fn.col(".") - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
-- end

local check_backspace = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- local icons = require("user.icons")
-- local kind_icons = icons.kind

local types = require("cmp.types")
local str = require("cmp.utils.str")
local compare = require("cmp.config.compare")

-- Luasnip
require("luasnip.loaders.from_vscode").lazy_load()

-- One peculiarity of honza/vim-snippets is that the file containing global
-- snippets is _.snippets, so we need to tell luasnip that the filetype "_"
-- contains global snippets:
luasnip.filetype_extend("all", { "_" })
luasnip.filetype_extend("typescript", { "javascript" })

cmp.setup({
	-- enabled = function()
	--   local buftype = vim.api.nvim_buf_get_option(0, "buftype")
	--   if buftype == "prompt" then
	--     return false
	--   end
	--   return vim.g.cmp_active
	-- end,
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			-- vim.fn["UltiSnips#Anon"](args.body) -- For ultisnips users.
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif check_backspace() then
				-- cmp.complete()
				fallback()
			else
				fallback()
			end
			-- if cmp.visible() then
			--   cmp.select_next_item()
			-- elseif check_backspace() then
			--   fallback()
			-- else
			--   fallback()
			-- end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
			-- if cmp.visible() then
			--   cmp.select_prev_item()
			-- else
			--   fallback()
			-- end
		end, {
			"i",
			"s",
		}),
	}),
	formatting = {
		fields = {
			cmp.ItemField.Abbr,
			cmp.ItemField.Kind,
			cmp.ItemField.Menu,
		},
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 60,
			before = function(entry, vim_item)
				vim_item.menu = ({
					nvim_lsp = "ﲳ",
					-- nvim_lua = "",
					cmp_tabnine = "ﮧ",
					treesitter = "",
					path = "ﱮ",
					buffer = "﬘",
					-- zsh = "",
					-- ultisnips = "",
					luasnip = "",
					spell = "暈",
				})[entry.source.name]

				-- Get the full snippet (and only keep first line)
				local word = entry:get_insert_text()
				if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
					word = vim.lsp.util.parse_snippet(word)
				end
				word = str.oneline(word)
				if
					entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
					and string.sub(vim_item.abbr, -1, -1) == "~"
				then
					word = word .. "~"
				end
				vim_item.abbr = word

				return vim_item
			end,
		}),
		-- format = function(entry, vim_item)
		--   -- Kind icons
		--   vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
		--
		--   if entry.source.name == "cmp_tabnine" then
		--     -- if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
		--     -- menu = entry.completion_item.data.detail .. " " .. menu
		--     -- end
		--     vim_item.kind = icons.misc.Robot
		--   end
		--
		--   -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
		--   vim_item.menu = ({
		--     ultisnips = "[Snippet]", -- For ultisnips users.
		--     nvim_lsp = "[LSP]",
		--     buffer = "[Buffer]",
		--     cmp_tabnine = "[TN]",
		--     path = "[Path]",
		--     emoji = "[Emoji]",
		--   })[entry.source.name]
		--   return vim_item
		-- end,
	},
	sources = {
		-- { name = "ultisnips" }, -- For ultisnips users.
		{ name = "luasnip", group_index = 2 },
		{
			name = "nvim_lsp",
			filter = function(entry, ctx)
				local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
				if kind == "Snippet" and ctx.prev_context.filetype == "java" then
					return true
				end

				if kind == "Text" then
					return true
				end
			end,
			group_index = 2,
		},
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
			group_index = 2,
		},
		{ name = "cmp_tabnine", group_index = 2 },
		{ name = "path", group_index = 2 },
		{ name = "treesitter", group_index = 2 },
		-- { name = "emoji" },
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			compare.offset,
			compare.exact,
			-- compare.scopes,
			compare.score,
			compare.recently_used,
			compare.locality,
			-- compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
		},
		completion = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
		},
	},
	experimental = {
		ghost_text = true,
	},
})
