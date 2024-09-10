return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
	keys = {
		{ '<leader>ff', require('telescope.builtin').find_files, desc = "telescope find_files" },
		{ '<leader>fg', require('telescope.builtin').live_grep, desc = "telescope live_grep"},
		{ '<leader>fb', require('telescope.builtin').buffers, desc = " telescope buffers"},
		{ '<leader>fh', require('telescope.builtin').help_tags, desc = "telescope help_tags"},
		{ '<leader>ft', require('telescope.builtin').treesitter, desc = "telescope treesitter"},
		{ '<leader>fc', require('telescope.builtin').command_history, desc = "telescope command_history"},
	},
    dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
		},
	},
}
