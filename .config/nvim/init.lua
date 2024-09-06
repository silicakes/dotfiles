-- imports
require("plug")

-- vim.cmd("colorscheme " .. colorscheme)
-- General settings
vim.cmd("set number relativenumber")
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)
vim.api.nvim_set_option("signcolumn", "yes")

-- Key Bindings
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "<C-a>", "<C-o>I")
vim.keymap.set("i", "<C-e>", "<C-o>A")
vim.keymap.set({ "n", "i" }, "<leader>w", "<ESC>:w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>1", ":tabe ~/.config/nvim/lua/plug.lua<CR>")
vim.keymap.set("n", "<leader>2", ":tabe ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>3", ":Telescope undo<CR>")
vim.keymap.set("n", "U", "<C-R>")
-- vim.keymap.set({ "n" }, "s", "<Plug>(leap-forward-to)")
-- vim.keymap.set("n", "-", ":20Lexplore<CR>")
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>ib", ":IBLToggle<CR>")

-- Copy / yank from system clipboard
vim.keymap.set({ "n", "i", "v" }, "<leader>Y", '"+Y')
vim.keymap.set({ "n", "i", "v" }, "<leader>y", '"+y')

-- Theme
-- require("rose-pine").setup({ variant = "moon" })
-- vim.cmd("colorscheme nord")
-- vim.cmd("colorscheme rose-pine")

-- Show current path
vim.keymap.set("n", "<leader>g", "<c-g>g")

-- Widths
vim.api.nvim_set_option("tabstop", 2)
vim.api.nvim_set_option("softtabstop", 2)
vim.api.nvim_set_option("shiftwidth", 2)

-- UFO folding
vim.opt.foldenable = true
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.wo.conceallevel = 2
vim.o.completeopt = "menuone,noinsert,noselect"

vim.api.nvim_create_user_command("Rfinder", function()
	local path = vim.api.nvim_buf_get_name(0)
	os.execute("open -R " .. path)
end, {})

-- Function to change the colorscheme
vim.opt.termguicolors = true
local colorscheme = "nightfox"
vim.cmd.colorscheme(colorscheme)
-- vim.cmd("hi Normal guibg=none")

local function change_colorscheme()
	vim.cmd([[set termguicolors]])
	local my_directory = vim.fn.expand("~/.vaults")
	local current_dir = vim.fn.expand("%:p:h")
	if string.match(current_dir, my_directory) then
		vim.cmd("colorscheme kanagawa")
	else
		vim.cmd.colorscheme(colorscheme)
	end
end

-- Create an autocommand
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
-- 	callback = change_colorscheme,
-- 	desc = "Change colorscheme when editing within a specific folder",
-- })

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		colorscheme = vim.g.colors_name
	end,
})
