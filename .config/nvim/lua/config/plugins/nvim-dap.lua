return {
	'mfussenegger/nvim-dap',
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"jbyuki/one-small-step-for-vimkind",
	},

	keys = {
		{ "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		{ "<leader>dE", function() require("dap").set_exception_breakpoints() end, desc = "Toggle Breakpoint" },
		{ "<leader>dL", function() require("dap").list_breakpoints() end, desc = "List Breakpoints" },
		{ "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
		{ "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
		{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
		{ "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
		{ "<leader>ds", function() require("dap").step_into() end, desc = "[S]tep Into" },
		{ "<leader>dj", function() require("dap").down() end, desc = "Down" },
		{ "<leader>dk", function() require("dap").up() end, desc = "Up" },
		{ "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
		{ "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
		{ "<leader>dn", function() require("dap").step_over() end, desc = "Step Over/[n]ext" },
		{ "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
		{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
		{ "<leader>dS", function() require("dap").session() end, desc = "Session" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
		{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
		{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
	},
	config = function ()
		-- see if the file exists
		local function file_exists(file)
			local f = io.open(file, "rb")
			if f then f:close() end
			return f ~= nil
		end

		-- get all lines from a file, returns an empty
		-- list/table if the file does not exist
		local function lines_from(file)
			if not file_exists(file) then return {} end
			local lines = {}
			for line in io.lines(file) do
				lines[#lines + 1] = line
			end
			return lines
		end

		-- tests the functions above
		local file = '.name_proc'
		local lines = lines_from(file)
		local prog
		local args

		if next(lines) ~= nil and #lines >= 1 then
			prog = lines[1]
			if lines[2] ~= nil then
				args = lines[2]
			end
		end
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dap-float",
			callback = function()
				vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<CR>", { noremap = true, silent = true })
			end
		})
		-- print all line numbers and their contents
		local dap = require("dap")
		local ui = require("dapui")
		local vt = require("nvim-dap-virtual-text")
		require('overseer').enable_dap()

		ui.setup()
		vt.setup({})
		dap.adapters.gdb = {
			type = "executable",
			command = "/usr/bin/gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
		}
		dap.configurations.c = {
  		{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					if prog then
						return prog
					end
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				args = function ()
					if args then
						return args
					end
					return vim.fn.input('Args: ')
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				pid = function()
					local name = vim.fn.input('Executable name (filter): ')
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = '${workspaceFolder}'
			},
			{
				name = 'Attach to gdbserver :1234',
				type = 'gdb',
				request = 'attach',
				target = ':1234',
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}'
			},
		}
		dap.configurations.cpp = dap.configurations.c

        dap.adapters.nlua = function(callback, conf)
          local adapter = {
            type = "server",
            host = conf.host or "127.0.0.1",
            port = conf.port or 8086,
          }
          if conf.start_neovim then
            local dap_run = dap.run
            dap.run = function(c)
              adapter.port = c.port
              adapter.host = c.host
            end
            require("osv").run_this()
            dap.run = dap_run
          end
          callback(adapter)
        end
        dap.configurations.lua = {
          {
            type = "nlua",
            request = "attach",
            name = "Run this file",
            start_neovim = {},
          },
          {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance (port = 8086)",
            port = 8086,
          },
        }
     	dap.listeners.before.attach.dapui_config = function()
     	  ui.open()
     	end
     	dap.listeners.before.launch.dapui_config = function()
     	  ui.open()
     	end
     	dap.listeners.before.event_terminated.dapui_config = function()
     	  ui.close()
     	end
     	dap.listeners.before.event_exited.dapui_config = function()
     	  ui.close()
     	end


	end
}
