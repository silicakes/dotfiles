local builtin = require("telescope.builtin")
local telescope = require("telescope")
local actions = require("telescope.actions")

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

telescope.setup({
	buffers = {
		sort_lastused = true,
	},
	defaults = {
		pickers = {
			find_files = {
				hidden = true,
			},
		},
		layout_config = {
			width = 0.7,
			height = 0.4,
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("undo")
