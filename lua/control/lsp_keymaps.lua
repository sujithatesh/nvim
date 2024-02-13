--lsp keymaps
local M = {}
local nmap = function(bufnr,keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

M.on_attach = function(_, bufnr)
  nmap(bufnr,'<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap(bufnr,'<leader>ca', function()
    vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
  end, '[C]ode [A]ction')

  nmap(bufnr,'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap(bufnr,'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap(bufnr,'gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap(bufnr,'<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap(bufnr,'<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap(bufnr,'<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap(bufnr,'K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap(bufnr,'<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap(bufnr,'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap(bufnr,'<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap(bufnr,'<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap(bufnr,'<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end
return M
