local builtin = require('telescope.builtin')
local opts = {silent = true, remap = false}
local dap = require('dap')


vim.api.nvim_set_keymap("n", "<TAB>a", ":Ag<cr>", {silent = false})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fc', builtin.command_history, {})

vim.keymap.set("n", "<C-left>", [[<cmd>vertical resize +5<cr>]], opts) -- make the window biger vertically
vim.keymap.set("n", "<C-right>", [[<cmd>vertical resize -5<cr>]], opts) -- make the window smaller vertically
vim.keymap.set("n", "<C-down>", [[<cmd>horizontal resize +2<cr>]], opts) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "<C-up>", [[<cmd>horizontal resize -2<cr>]], opts) -- make the window smaller horizontally by pressing shift and -
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function()
  require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F12>", dap.restart)

