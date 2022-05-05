local M = {}

local overridePlugins = require("custom.plugins.overrides")
local userPlugins = require("custom.plugins")

M.plugins = {
	user = userPlugins,
	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},
	},
	statusline = {
		separator_style = "arrow",
	},
	override = {
		["goolord/alpha-nvim"] = overridePlugins.alpha,
	},
}

M.ui = {
	theme = "onenord",
}

M.mappings = {
	misc = function()
		local map = require("core.utils").map

		-- get out of terminal mode
		map("t", { "JK" }, "<C-\\><C-n>")

		-- toggle comments
		map("n", "<leader>º", "<cmd> :lua require('Comment.api').toggle_current_linewise()<CR>")
		map("v", "<leader>º", "<esc><cmd> :lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")
	end,
}

return M
