-------------------------------------------------
-- COLORSCHEMES
-------------------------------------------------
local ok, _ = pcall(vim.cmd, 'colorscheme base16-oceanicnext')
-- monokai
-- nord
-- oceanicnext
-- solarized-dark
-- solarized-light

vim.api.nvim_create_autocmd("TextYankPost", {
	group = num_au,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
	end,
})
