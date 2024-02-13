-- Define a global variable to keep track of terminal state
_G.toggle_terminal = false

-- Function to toggle terminal
local function toggle_terminal()
    if _G.toggle_terminal then
        vim.cmd('bd!')
        _G.toggle_terminal = false
    else
        vim.cmd('split term://$SHELL')
        _G.toggle_terminal = true
    end
end

-- Map the function to a keybinding
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua toggle_terminal()<CR>', {noremap = true, silent = true})
