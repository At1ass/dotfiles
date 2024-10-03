return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
	keys = {
		{ '<leader>f', '', desc = '+Telescope'},
		{ '<leader>ff', require('telescope.builtin').find_files, desc = "telescope find_files" },
		{ '<leader>fg', require('telescope.builtin').live_grep, desc = "telescope live_grep"},
		{ '<leader>fs', require('telescope.builtin').grep_string, desc = "telescope grep_string", mode = {'n', 'v'}},
		{ '<leader>fb', require('telescope.builtin').buffers, desc = " telescope buffers"},
		{ '<leader>fh', require('telescope.builtin').help_tags, desc = "telescope help_tags"},
		{ '<leader>ft', require('telescope.builtin').treesitter, desc = "telescope treesitter"},
		{ '<leader>fc', require('telescope.builtin').command_history, desc = "telescope command_history"},
		{ '<leader>fld', require('telescope.builtin').lsp_dynamic_workspace_symbols, desc = "telescope command_history"},
	},
    dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
		},
	},
	opts = {
		extensions = {
			fzf = {
				fuzzy = true,                    -- false will only do exact matching
				override_generic_sorter = true,  -- override the generic sorter
				override_file_sorter = true,     -- override the file sorter
				case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			}
  }
	}
}
