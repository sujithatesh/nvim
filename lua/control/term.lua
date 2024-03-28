-- Define a global variable to keep track of terminal state
_G.toggle_terminal = false
_G.term_num = false

-- Function to toggle terminal
--[[ function Toggle_terminal()
    if _G.toggle_terminal then
        vim.cmd('q')
        _G.toggle_terminal = false
    else
        vim.cmd('vsplit term://$SHELL')
        vim.cmd('vsplit term://$SHELL')
        _G.toggle_terminal = true
    end
end ]]
-- Function to toggle the dedicated terminal buffer

function buffer_exists(name)
    for _, buf in ipairs(vim.fn.getbufinfo()) do
        if buf.name == name then
            return true
        end
    end
    return false
end

function toggle_dedicated_terminal()
    local buf_number = 30
    vim.cmd("badd " .. buf_number)
    if buffer_exists(buf_number) then
        local win_id = vim.fn.bufwinnr(buf_number)
        if win_id ~= -1 then
            -- If the buffer is already visible in a window, close it
            vim.cmd(string.format('%dclose', win_id))
        else
            -- If the buffer is not visible, open it in a new window
            vim.cmd(string.format('vsplit | buffer %d', buf_number))
            -- Run the terminal command in the new buffer
            vim.fn.termopen("$SHELL")
        end
    else
        -- If the buffer doesn't exist, create and open it in a new window
        vim.cmd(string.format('vsplit | buffer %d', buf_number))
        -- Run the terminal command in the new buffer
        vim.fn.termopen("$SHELL")
    end
end

-- Map <leader>t to toggle the dedicated terminal buffer
vim.api.nvim_set_keymap('n', '<leader>t', ':lua toggle_dedicated_terminal()<CR>', { noremap = true, silent = true })
