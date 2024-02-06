return {
  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "williamboman/mason.nvim", 
      "williamboman/mason-lspconfig.nvim",
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    ft = {"c", "lua"},
    config = function()
      -- Setup mason so it can manage 3rd party LSP servers
      require("mason").setup({
	ui = {
	  border = "rounded",
	},
      })

      local cmp = require('cmp')
      local luasnip = require('luasnip')

      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
	snippet = {
	  expand = function(args)
	    luasnip.lsp_expand(args.body)
	  end,
	},
	completion = {
	  completeopt = 'menu,menuone,noinsert',
	},
	window = {
	  completion = cmp.config.window.bordered(),
	  documentation = cmp.config.window.bordered(),
	},
	mapping = {
	  ['<C-j>'] = cmp.mapping.select_next_item(),
	  ['<C-k>'] = cmp.mapping.select_prev_item(),
	  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
	  ['<C-f>'] = cmp.mapping.scroll_docs(4),
	  ['<C-Space>'] = cmp.mapping.complete {},
	  ['<CR>'] = cmp.mapping.confirm {
	    behavior = cmp.ConfirmBehavior.Replace,
	    select = true,
	  },
	},
	sources = {
	  { name = 'nvim_lsp' },
	  { name = 'luasnip' },
	  { name = 'path' },
	  { name = 'friendly-snippets' },
	},
      }

      local servers = {
	clangd = {
	  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
	},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- tsserver = {},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },
	lua_ls = {
	  Lua = {
	    workspace = { checkThirdParty = false },
	    diagnostics = {
	      disable = { 'undefined-global' },
	    },
	  },
	},
      }
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- rounded
      local default_handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }
      vim.diagnostic.config({
	severity_sort = true,
	signs = {
	  text = {
	    [vim.diagnostic.severity.ERROR] = 'E',
	  }
	},
	underline = {
	  severity = vim.diagnostic.severity.ERROR
	},
	float = {
	  border = "rounded",
	},
	virtual_text = {
	  severity = vim.diagnostic.severity.ERROR
	}
      })

      local on_attach = require('user.control.lsp_keymaps').on_attach
      for name, config in pairs(servers) do
	require("lspconfig")[name].setup({
	  capabilities = capabilities,
	  filetypes = config.filetypes,
	  handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
	  on_attach = on_attach,
	  settings = config.settings,
	})
      end
    end
  }

}
