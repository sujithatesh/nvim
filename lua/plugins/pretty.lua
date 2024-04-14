return {
    -- Add indentation guides even on blank lines
    {
        'lukas-reineke/indent-blankline.nvim', -- Enable `lukas-reineke/indent-blankline.nvim`
        main = 'ibl',
        opts = {},
    },

    -- "gc" to comment visual regions/lines
    {
        'numToStr/Comment.nvim',
        opts = {
            opleader = {
                ---Line-comment keymap
                line = 'gc',
                ---Block-comment keymap
                block = 'gb',
            },
        }
    },

    -- Detect tabstop and shiftwidth automatically
    {
        'tpope/vim-sleuth',
    },
}
