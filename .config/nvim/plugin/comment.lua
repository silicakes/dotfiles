require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

	toggler = {
		---Line-comment toggle keymap
		line = "<leader>c<space>",
		---Block-comment toggle keymap
		block = "<leader>b<space>",
	},
})
