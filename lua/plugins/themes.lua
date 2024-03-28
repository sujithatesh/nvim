return {
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = true,
		opts = ...,
		config = function()
			require('onedark').setup({
				transparent = true
			})
			-- require('onedark').load()
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		opts = ...,
		config = function()
			require('tokyonight').setup({
				style = "night",
				transparent = true,
				styles = {
					floats = "transparent"
				}
			})
			-- require('tokyonight').load()
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = ...,
		config = function()
			require('gruvbox').setup({
				transparent_mode = true,
			})
			require('gruvbox').load()
		end,
	}
}
