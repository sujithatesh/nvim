return {
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
