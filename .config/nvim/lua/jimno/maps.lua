local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

-- call vifm
map("n", "<leader>vf", "<CMD>Vifm<CR>")

-- Keybindings for telescope
map("n", "<leader>fo", "<CMD>Telescope oldfiles<CR>")
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>")

-- Keybindings for tpope commentary plugin
map("n", "\\\\", "<Plug>CommentaryLine")
map("x", "\\\\", "<Plug>Commentary")
