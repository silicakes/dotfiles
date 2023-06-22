-- Utilities for creating configurations
local util = require("formatter.util")

local formatter_config = {
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			function()
				-- Supports conditional formatting
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
	},
}

function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

local prettierd_config = function()
	local local_path = "node_modules/prettier/bin/prettier"
	return {
		exe = (file_exists(local_path) and local_path or "prettier"),
		args = { vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local prettierd_files =
{ "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css", "scss", "json" }

for _, ft in ipairs(prettierd_files) do
	formatter_config.filetype[ft] = { prettierd_config }
end

-- print(dump(formatter_config))
-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup(formatter_config)
