return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = { },
	keys = {
		{"<leader>G", "", desc = "+Gitsigns", mode = {"n"}},
		{"<leader>Gp", ":Gitsigns preview_hunk<cr>", {},},
		{'<leader>Gs', ':Gitsigns stage_hunk<CR>', {}},
		{'<leader>Gr', ':Gitsigns reset_hunk<CR>', {}},
	}
}
