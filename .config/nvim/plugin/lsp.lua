local util = require("lspconfig.util")
require("yaml-companion").setup({})

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

-- local lsp = require("lsp-zero").preset({})
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- lsp.set_preferences({
-- 	suggest_lsp_servers = true,
-- 	setup_servers_on_start = true,
-- 	set_lsp_keymaps = true,
-- 	configure_diagnostics = true,
-- 	cmp_capabilities = true,
-- 	manage_nvim_cmp = true,
-- 	call_servers = "local",
-- 	sign_icons = {
-- 		error = "✘",
-- 		warn = "▲",
-- 		hint = "⚑",
-- 		info = "",
-- 	},
-- })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	update_in_insert = true,
})

-- enable inline diagnostics
vim.diagnostic.config({
	virtual_text = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

-- lsp.on_attach(function(client, bufnr)
-- 	local opts = { buffer = bufnr }
-- 	lsp.default_keymaps(opts)
-- 	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
-- 	vim.keymap.set({ "n", "v" }, "<leader>ac", vim.lsp.buf.code_action, opts)
-- end)

-- (Optional) Configure lua language server for neovim
-- require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

-- local lspconfig = require("lspconfig")
local lspconfig = vim.lsp.config

-- vim.lsp.set_log_level("debug")
-- local on_attach = function(client)
-- 	require("completion").on_attach(client)
-- end
--
--

-- lspconfig.tsserver.setup({
-- 	capabilities = capabilities,
-- 	-- cmd = { "node", "./node_modules/typescript/lib/tsserver.js", "--stdio" },
-- })
--
lspconfig("yamlls", {
	capabilities = capabilities,
})

require("typescript-tools").setup({
	capabilities = capabilities,
	settings = {
		-- spawn additional tsserver instance to calculate diagnostics on it
		-- separate_diagnostic_server = true,
		-- "change"|"insert_leave" determine when the client asks the server about diagnostic
		publish_diagnostic_on = "change",
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "all",
			includeInlayEnumMemberValueHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayVariableTypeHints = true,
			quotePreference = "auto",
		},
		tsserver_format_options = {
			allowIncompleteCompletions = false,
			allowRenameOfImportPath = false,
		},
	},
})

lspconfig("tailwindcss", {
	capabilities = capabilities,
})

lspconfig("prismals", {
	capabilities = capabilities,
})

lspconfig("jsonls", {
	capabilities = capabilities,
	filetypes = { "json", "jsonc" },
	settings = {
		json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
	},
})

-- Supress warning for global vim
lspconfig("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- lspconfig.pylyzer.setup({
-- 	capabilities = capabilities,
-- })

lspconfig("rust_analyzer", {
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

-- lsp.setup()
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keymap_opts)
vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, keymap_opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
vim.keymap.set("n", "<leader>fs", ":lua vim.lsp.buf.format({async = true})<CR> <BAR> <cmd>update<CR>") -- format on save
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
