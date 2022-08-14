local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
	return
end

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- local icons = require("user.icons")
-- local kind_icons = icons.kind

local types = require("cmp.types")
local str = require("cmp.utils.str")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body) -- For ultisnips users.
		end,
	},
	mapping = {
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
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
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
					cmp_tabnine = "",
					treesitter = "",
					path = "ﱮ",
					buffer = "﬘",
					-- zsh = "",
					ultisnips = "",
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
		{ name = "ultisnips" }, -- For ultisnips users.
		{ name = "nvim_lsp" },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "cmp_tabnine" },
		{ name = "path" },
		{ name = "treesitter" },
		-- { name = "emoji" },
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
		native_menu = false,
	},
})
