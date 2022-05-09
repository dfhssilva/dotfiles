local M = {}

local overridePlugins = require("custom.plugins.overrides")
local userPlugins = require("custom.plugins")

local delmap = function(mode, keys, opts)
  vim.keymap.del(mode, keys, opts)
end


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
	 		["akinsho/bufferline.nvim"] = overridePlugins.bufferline,
                        ["goolord/alpha-nvim"] = overridePlugins.alpha,
	},
}

M.ui = {
	theme = "onenord",
}

M.mappings = {
	misc = function()
		local map = require("core.utils").map

		-- override terminal mappings
                delmap("t", "jk")
		map("t", { "JK" }, "<C-\\><C-n>")

		-- toggle comments
		map("n", "<leader>º", "<cmd> :lua require('Comment.api').toggle_current_linewise()<CR>")
		map("v", "<leader>º", "<esc><cmd> :lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")
	end,
}

return M
