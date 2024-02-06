return {
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('onedark').setup {
        style = 'cool', -- dark, darker, cool, deep, warm, warmer, light
      }
      require('onedark').load()
    end,
  },
}
