local M = {}

local function termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- add this table only when you want to disable default keys
M.disabled = {
	t = {
		["jk"] = "",
	},
	n = {
		["<leader>/"] = "",
	},
	v = {
		["<leader>/"] = "",
	},
}

M.general = {

	t = {
		["JK"] = { termcodes("<C-\\><C-N>"), "   escape terminal mode" },
	},
}

M.comment = {

	-- toggle comment in both modes
	n = {
		["<leader>º"] = {
			function()
				require("Comment.api").toggle_current_linewise()
			end,

			"蘒  toggle comment",
		},
	},

	v = {
		["<leader>º"] = {
			"<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
			"蘒  toggle comment",
		},
	},
}

return M
