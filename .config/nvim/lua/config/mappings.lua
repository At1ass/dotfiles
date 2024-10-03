local builtin = require('telescope.builtin')
local opts = {silent = true, remap = false}
local dap = require('dap')


vim.api.nvim_set_keymap("n", "<TAB>a", ":Ag<cr>", {silent = false})
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", {remap = false})
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", {remap = false})
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<cr>==gi", {remap = false})
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<cr>==gi", {remap = false})
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", {remap = false})
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", {remap = false})

vim.keymap.set("n", "<C-left>", [[<cmd>vertical resize +5<cr>]], opts) -- make the window biger vertically
vim.keymap.set("n", "<C-right>", [[<cmd>vertical resize -5<cr>]], opts) -- make the window smaller vertically
vim.keymap.set("n", "<C-down>", [[<cmd>horizontal resize +2<cr>]], opts) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "<C-up>", [[<cmd>horizontal resize -2<cr>]], opts) -- make the window smaller horizontally by pressing shift and -
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function()
  require("dapui").eval(nil, { enter = true })
end)
