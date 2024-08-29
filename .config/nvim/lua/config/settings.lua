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

require('telescope').load_extension('fzf')
