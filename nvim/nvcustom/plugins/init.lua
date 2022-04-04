-- Plugins file

return {
	{
		-- LSP-installer: allows you to seamlessly manage LSP servers locally
		"williamboman/nvim-lsp-installer",
		opt = true,
		config = function()
			local lsp_installer = require("nvim-lsp-installer")
			lsp_installer.on_server_ready(function(server)
				local opts = {}
				server:setup(opts)
				vim.cmd([[ do User LspAttachBuffers ]])
			end)
		end,
		setup = function()
			require("core.utils").packer_lazy_load("nvim-lsp-installer")
		end,
	},
	{
		-- Null-ls: Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
		"jose-elias-alvarez/null-ls.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls").setup()
		end,
	},
	{
		-- Stabilize: a plugin to stabilize window open/close events
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	},
	{
		-- capslock.vim: Software caps lock
		"tpope/vim-capslock",
	},
	{
		-- tmux_navigator.vim: Seamless navigation between tmux panes and vim splits
		"christoomey/vim-tmux-navigator",
	},
}
