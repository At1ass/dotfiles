return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
		'nvim-tree/nvim-web-devicons',
		'morhetz/gruvbox',
		'sainnhe/gruvbox-material',
	},

	opts = function ()

		local opts = {
			options = {
				icons_enabled = true,
				theme = 'gruvbox-material',
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
				disabled_filetypes = {
					statusline = {},
					winbar = {},
					'neo-tree',
					'tagbar'
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},

			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch'},
				lualine_c = {'trouble'},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'trouble'},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { 'trouble'}
		}
		local trouble = require("trouble")
		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			-- The following line is needed to fix the background color
			-- Set it to the lualine section you want to use
			hl_group = "lualine_c_normal",
		})
		table.insert(opts.sections.lualine_c, {
			symbols.get,
			cond = symbols.has,
		})

		return opts
	end,
}
