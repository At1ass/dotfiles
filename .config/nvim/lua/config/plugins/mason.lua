return {
    "williamboman/mason-lspconfig.nvim",
	dependencies = {
    		"williamboman/mason.nvim",
    		"neovim/nvim-lspconfig",
			"p00f/clangd_extensions.nvim",
	},

	config = function ()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"lua_ls",
				"rust_analyzer",
				"bashls",
				"zls",
			}
		})

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

				local capabilities = require("cmp_nvim_lsp").default_capabilities()
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = function (client, bufnr)
						lsp_keymap(bufnr)
					end,
				})
			end
		})

		require("clangd_extensions.inlay_hints").setup_autocmd()
		require("clangd_extensions.inlay_hints").set_inlay_hints()
		require("clangd_extensions").setup({
		    inlay_hints = {
		        inline = vim.fn.has("nvim-0.10") == 1,
		        -- Options other than `highlight' and `priority' only work
		        -- if `inline' is disabled
		        -- Only show inlay hints for the current line
		        only_current_line = false,
		        -- Event which triggers a refresh of the inlay hints.
		        -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
		        -- note that this may cause higher CPU usage.
		        -- This option is only respected when only_current_line is true.
		        only_current_line_autocmd = { "CursorHold" },
		        -- whether to show parameter hints with the inlay hints or not
		        show_parameter_hints = true,
		        -- prefix for parameter hints
		        parameter_hints_prefix = "<- ",
		        -- prefix for all the other hints (type, chaining)
		        other_hints_prefix = "=> ",
		        -- whether to align to the length of the longest line in the file
		        max_len_align = false,
		        -- padding from the left if max_len_align is true
		        max_len_align_padding = 1,
		        -- whether to align to the extreme right or not
		        right_align = false,
		        -- padding from the right if right_align is true
		        right_align_padding = 7,
		        -- The color of the hints
		        highlight = "Comment",
		        -- The highlight group priority for extmark
		        priority = 100,
		    },
		    ast = {
		        -- These are unicode, should be available in any font
		        role_icons = {
		            type = "🄣",
		            declaration = "🄓",
		            expression = "🄔",
		            statement = ";",
		            specifier = "🄢",
		            ["template argument"] = "🆃",
		        },
		        kind_icons = {
		            Compound = "🄲",
		            Recovery = "🅁",
		            TranslationUnit = "🅄",
		            PackExpansion = "🄿",
		            TemplateTypeParm = "🅃",
		            TemplateTemplateParm = "🅃",
		            TemplateParamObject = "🅃",
		        },
		        --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
		            role_icons = {
		                type = "",
		                declaration = "",
		                expression = "",
		                specifier = "",
		                statement = "",
		                ["template argument"] = "",
		            },

		            kind_icons = {
		                Compound = "",
		                Recovery = "",
		                TranslationUnit = "",
		                PackExpansion = "",
		                TemplateTypeParm = "",
		                TemplateTemplateParm = "",
		                TemplateParamObject = "",
		            }, ]]

		        highlights = {
		            detail = "Comment",
		        },
		    },
		    memory_usage = {
		        border = "none",
		    },
		    symbol_info = {
		        border = "none",
		    },
		})
	end
}
