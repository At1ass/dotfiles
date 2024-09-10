local global = vim.g
local o = vim.opt
local colorscheme = "gruvbox-material"

o.number = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.syntax = "on"
o.tabstop = 4
o.shiftwidth = 4
o.termguicolors = true
o.winbar = "%=%m %f"
global.c_syntax_for_h = 1
global.python3_host_prog = "/usr/bin/python3.11"


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
vim.api.nvim_create_autocmd(
{ "FileType" },
{
  callback = function()
    if require("nvim-treesitter.parsers").has_parser() then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    else
      vim.opt.foldmethod = "syntax"
    end
  end,
})
vim.opt.completeopt =  { "menu", "noinsert", "noinsert"}
--o.foldlevel=20
--o.foldenable = false
vim.wo.foldcolumn = '1'
vim.wo.foldlevel=20
vim.wo.foldminlines = 1
vim.wo.foldenable = false

require('telescope').load_extension('fzf')
