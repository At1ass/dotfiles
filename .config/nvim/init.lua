if vim.loader then
	vim.loader.enable()
end
require("config.lazy")
require("config.settings")
require("config.mappings")
