local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
	-- LaTeX
	b.formatting.latexindent,

	-- Lua
	b.formatting.stylua,

	-- Shell
	b.formatting.shfmt,

	-- Proselint
	b.diagnostics.proselint,

	-- Python
	b.formatting.isort,
	b.formatting.black,
	b.diagnostics.pydocstyle,
}

local M = {}

M.setup = function()
	null_ls.setup({
		sources = sources,

		-- format on save
		on_attach = function(client)
			if client.resolved_capabilities.document_formatting then
				vim.cmd([[
              augroup LspFormatting
                  autocmd! * <buffer>
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
              augroup END
              ]])
			end
		end,
	})
end

return M
