return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{
			"williamboman/mason.nvim",
		},
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function (_, opts)
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"lua_ls",
				"rust_analyzer",
				"bashls",
				"zls",
				"gopls",

			}
		})
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				local function lsp_keymap(bufnr)
					local bufopts = { noremap=true, silent=true, buffer=bufnr }
						vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
						vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
						vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
						vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
						vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
						vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
						vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
						vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
						vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
						vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
						vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
						if server_name == 'clangd' then
							vim.keymap.set('n', '<leader>h', ':ClangdSwitchSourceHeader<cr>', bufopts)
						end
					end
				--
				require("lspconfig")[server_name].setup({
					on_init = function(client)
						local path = client.workspace_folders[1].name
						if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      						return
    					end

						client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
							runtime = {
							  version = 'LuaJIT'
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
							  checkThirdParty = false,
							  library = {
							    vim.env.VIMRUNTIME,
							    -- Depending on the usage, you might want to add additional paths here.
							    "${3rd}/luv/library",
							    "${3rd}/busted/library",
							  }
							}
						})
					end,
					capabilities = capabilities,
					inlay_hint = {
						enabled = true,
					},
					on_attach = function (_, bufnr)
						lsp_keymap(bufnr)
					end,
					settings = {
						Lua = {
							completion = {callSnippet = 'Replace',},
							diagnostics = {globals = {'vim'}}
						},
						clangd = {
							InlayHints = {
								Designators = true,
								Enabled = true,
								ParameterNames = true,
								DeducedTypes = true,
							},
							fallbackFlags = { "-std=c++20" },
						},
					},

				})
			end,
			["rust_analyzer"] = function ()	end,
			["clangd"] = function () end,
		})
		require('lspconfig').clangd.setup({
			keys = {
				{ "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
			},
			root_dir = function(fname)
				return require("lspconfig.util").root_pattern(
				"Makefile",
				"configure.ac",
				"configure.in",
				"config.h.in",
				"meson.build",
				"meson_options.txt",
				"build.ninja"
				)(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
				fname
				) or require("lspconfig.util").find_git_ancestor(fname)
			end,
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
			inlay_hint = {
				enabled = true,
			},
		})
	end
}
