local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

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
