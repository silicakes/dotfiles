local util = require("lspconfig.util")

-- LSP Diagnostics Options Setup
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end
sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })
--
-- vim.diagnostic.config({
-- 	virtual_text = false,
-- 	signs = true,
-- 	update_in_insert = true,
-- 	underline = true,
-- 	severity_sort = false,
-- 	float = {
-- 		border = "rounded",
-- 		source = "always",
-- 		header = "",
-- 		prefix = "",
-- 	},
-- })
-- =========================================================

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Format on save that actually works
vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])

local lsp = require("lsp-zero").preset({})
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr }
	lsp.default_keymaps(opts)
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ac", vim.lsp.buf.code_action, opts)
end)

-- (Optional) Configure lua language server for neovim
-- require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

local lspconfig = require("lspconfig")

-- vim.lsp.set_log_level("debug")
-- local on_attach = function(client)
-- 	require("completion").on_attach(client)
-- end
--
--

lspconfig.tsserver.setup({
	capabilities = capabilities,
	-- cmd = { "node", "./node_modules/typescript/lib/tsserver.js", "--stdio" },
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
})

lspconfig.prismals.setup({
	capabilities = capabilities,
})

-- Supress warning for global vim
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lspconfig.pylyzer.setup({
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			files = {
				excludeDirs = { "$HOME", "$HOME/.cargo/**", "$HOME/.rustup/**", "target", "node_modules", "." },
				watcherExclude = { "$HOME", "$HOME/.cargo/**", "$HOME/.rustup/**", "target", "node_modules" },
			},
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			check = {
				command = "clippy",
			},
			checkOnSave = {
				command = "clippy",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})
lsp.setup()

-- Completion Plugin Setup
-- Keeping it here because it requires a specific order
-- local cmp = require("cmp")
-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args)
-- 			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
-- 		end,
-- 	},
--
-- 	mapping = {
-- 		["<C-p>"] = cmp.mapping.select_prev_item(),
-- 		["<C-n>"] = cmp.mapping.select_next_item(),
-- 		-- Add tab support
-- 		["<S-Tab>"] = cmp.mapping.select_prev_item(),
-- 		["<Tab>"] = cmp.mapping.select_next_item(),
-- 		["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-Space>"] = cmp.mapping.complete(),
-- 		["<C-e>"] = cmp.mapping.close(),
-- 		["<CR>"] = cmp.mapping.confirm({
-- 			behavior = cmp.ConfirmBehavior.Insert,
-- 			select = true,
-- 		}),
-- 	},
-- 	-- Installed sources:
-- 	sources = {
-- 		{ name = "path" }, -- file paths
-- 		{ name = "nvim_lsp", keyword_length = 3 }, -- from language server
-- 		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
-- 		{ name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
-- 		{ name = "buffer", keyword_length = 2 }, -- source current buffer
-- 		{ name = "luasnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
-- 		{ name = "calc" }, -- source for math calculation
-- 	},
-- 	window = {
-- 		completion = cmp.config.window.bordered(),
-- 		documentation = cmp.config.window.bordered(),
-- 	},
-- 	formatting = {
-- 		fields = { "menu", "abbr", "kind" },
-- 		format = function(entry, item)
-- 			local menu_icon = {
-- 				nvim_lsp = "λ",
-- 				luasnip = "⋗",
-- 				buffer = "Ω",
-- 				path = "🖫",
-- 			}
-- 			item.menu = menu_icon[entry.source.name]
-- 			return item
-- 		end,
-- 	},
-- })
