return{
	'mrcjkb/rustaceanvim',
	version = '^5', -- Recommended
	lazy = false, -- This plugin is already lazy

	ft = { "rust" },
	config = function(_,_)
		vim.g.rustaceanvim = {
			server = {
				on_attach = function(client, buffer)
					local bufopts = { noremap=true, silent=true, buffer=buffer }
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
				end,
			},
		}
	end
}
