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
	override = {
		["goolord/alpha-nvim"] = overridePlugins.alpha,
		["akinsho/bufferline.nvim"] = overridePlugins.bufferline,
	},
}

M.ui = {
	theme = "onenord",
	theme_toggle = { "onenord", "onenord_light" },
}

M.mappings = require("custom.mappings")

return M
