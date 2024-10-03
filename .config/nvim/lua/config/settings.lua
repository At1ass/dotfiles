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
local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
require('telescope').load_extension('fzf')


vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function ()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 300,
		})
	end
})
