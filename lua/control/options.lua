-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.splitright = true

vim.o.makeprg = "./run.sh"

vim.opt.swapfile = false

vim.g.netrw_keep_dir = 0 
vim.g.netrw_banner = 0;
vim.g.netrw_sort_options = {'sortdirs', 'slash'}
vim.g.netrw_preview = 1
vim.g.netrw_list_hide = '^\\./$'

vim.api.nvim_create_autocmd({"TermOpen", "TermEnter"}, {
  pattern = { "term://*" },
  callback = function()
    vim.wo.relativenumber	= false
    vim.wo.number		= false
    vim.o.signcolumn		= "no"
    vim.cmd([[ startinsert ]])
  end,
})

