-- This file can be loaded by calling `lua require('plugins')` from your init.vim
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) -- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself

    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use("lukas-reineke/indent-blankline.nvim")

    use({ 'folke/tokyonight.nvim', as = 'tokyo-night' })

    use({ 'rose-pine/neovim', as = 'rose-pine' })

    vim.cmd('colorscheme rose-pine')

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use('nvim-treesitter/playground')

    use('theprimeagen/harpoon')

    use('nvim-lua/plenary.nvim')


    use('mbbill/undotree')

    use('tpope/vim-fugitive')

    use('windwp/nvim-ts-autotag')

    use('mfussenegger/nvim-dap')

    use('theHamsta/nvim-dap-virtual-text')

    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    use { "akinsho/toggleterm.nvim", tag = '*',
        config = function()
            require("toggleterm").setup {
                size = 10,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                start_in_insert = true,
                persist_size = true,
                persist_mode = true,
                direction = 'horizontal',
                insert_mappings = true,
                winbar = {
                    enabled = false,
                    name_formatter = function(term) --  term: Terminal
                        return term.name
                    end
                },
            }
        end
    }


    --setup lsp-zero nvim
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
end)
