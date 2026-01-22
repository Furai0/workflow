-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	-- Off background
-- 	opts = {
-- 		transparent = true,
-- 		styles = {
-- 			sidebars = "transparent",
-- 			floats = "transparent",
-- 		},
-- 	},
-- 	config = function(_, opts)
-- 		require("tokyonight").setup(opts)
-- 		vim.cmd([[colorscheme tokyonight]])
-- 		vim.cmd([[
-- 			highlight NvimTreeNormal guifg=#ffffff
-- 		]])
-- 	end,
-- }

return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			disable_background = true, -- Off background
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
