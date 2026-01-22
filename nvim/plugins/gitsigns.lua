return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "┃" },
					topdelete = { text = "‾" },
					changedelete = { text = "┃" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "┃" },
					topdelete = { text = "‾" },
					changedelete = { text = "┃" },
					untracked = { text = "┆" },
				},
			})

			vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#012b16" })
			vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#683809" })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#3a1304" })
			vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#05253f" })
			vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#ff0000" })
			vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#00ffff" })

			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gs", ":Gitsigns toggle_current_line_blame<CR>", { silent = true })
		end,
	},
}
