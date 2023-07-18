-- imports
require("plug")

-- General settings
vim.cmd("set number relativenumber")
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Key Bindings
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "<C-a>", "<C-o>I")
vim.keymap.set("i", "<C-e>", "<C-o>A")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>1", ":new ~/.config/nvim/lua/plug.lua<CR>")
vim.keymap.set("n", "<leader>2", ":new ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>3", ":Telescope undo<CR>")
vim.keymap.set("n", "U", "<C-R>")
-- vim.keymap.set("n", "-", ":20Lexplore<CR>")
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>ib", ":IndentBlanklineToggle<CR>")

-- Theme
-- require("rose-pine").setup({ variant = "moon" })
vim.cmd("colorscheme nord")

-- Widths
vim.api.nvim_set_option("tabstop", 2)
vim.api.nvim_set_option("softtabstop", 2)
vim.api.nvim_set_option("shiftwidth", 2)

-- Treesitter folding
vim.opt.foldenable = false
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = "3"
vim.opt.foldlevel = 99
vim.o.completeopt = "menuone,noinsert,noselect"

-- change to current buffers cwd
-- vim.opt.autochdir = true
