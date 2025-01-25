return {
	-- LSP Configuration & Plugins
	--[[ {
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
		config = function()
			-- Setup mason so it can manage 3rd party LSP servers
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
			local cmp = require('cmp')
			local luasnip = require('luasnip')
			local lspconfig = require('lspconfig')

			require('luasnip.loaders.from_vscode').lazy_load()
			luasnip.config.setup {
				vim.keymap.set({ "i" }, "<C-K>", function() luasnip.expand() end, { silent = true }),
				vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true }),
				vim.keymap.set({ "i", "s" }, "<C-J>", function() luasnip.jump(-1) end, { silent = true }),
				vim.keymap.set({ "i", "s" }, "<C-E>", function()
					if luasnip.choice_active() then
						luasnip.change_choice(1)
					end
				end, { silent = true }),
			}

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
					['<Tab>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Enter>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'friendly-snippets' },
					{ name = 'path' },
				},
			}

			local servers = {
				gopls = {
					filetypes = {'go'}
				},
				glsl_analyzer = {
					filetypes = {'vs', 'fs', 'glsl'}
				},
				clangd = {
					filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
				},
				-- gopls = {},
				pyright = {
					filetypes = { 'python' },
				},
				rust_analyzer = {
					filetypes = { 'rust', 'cargo' },
				},
				denols = {
					filetypes = { 'javascript', 'typescript' },
					setup = {
						root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
					}
				},
				html = { filetypes = { 'html', 'twig', 'hbs' } },
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
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
					{ border = "rounded" }),
			}
			vim.diagnostic.config({
				update_in_insert = true,
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
					focusable = true,
					style = 'minimal',
					source = 'always',
					header = '',
					scope = 'line',
					prefix = '',
				},
				virtual_text = {
					severity = vim.diagnostic.severity.ERROR
				}
			})

			local on_attach = require('control.lsp_keymaps').on_attach
			for name, config in pairs(servers) do
				require("lspconfig")[name].setup({
					capabilities = capabilities,
					filetypes = config.filetypes,
					handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
					on_attach = on_attach,
					settings = config.settings,
					setup = config.setup
				})
			end
		end
	} ]]
}
