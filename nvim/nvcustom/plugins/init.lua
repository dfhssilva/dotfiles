return {
	--------------------------------------------- Existing plugins -------------------------------------------
	["goolord/alpha-nvim"] = {
		disable = false,
	},
	--------------------------------------------- Addeded plugins --------------------------------------------
	-- Null-ls: Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls").setup()
		end,
	},
	-- Stabilize: a plugin to stabilize window open/close events
	["luukvbaal/stabilize.nvim"] = {
		config = function()
			require("stabilize").setup()
		end,
	},
}
