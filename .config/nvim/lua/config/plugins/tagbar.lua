return {
	"preservim/tagbar",

	init = function ()
		vim.api.nvim_create_autocmd(
			{"FileType"},{
			once = true,
			nested = true,
			pattern = {'c', 'h', 'cc', 'cpp', 'hpp'},
			command = "TagbarToggle",
			}
		)
	end
}
