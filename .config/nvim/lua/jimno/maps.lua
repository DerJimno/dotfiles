local function map(m, k, v, opts)
  opts = opts or {}
  opts.silent = true
  vim.keymap.set(m, k, v, opts)
end

-- call vifm
map("n", "<leader>vf", "<CMD>Vifm<CR>")

-- Keybindings for telescope
map("n", "<leader>fo", "<CMD>Telescope oldfiles<CR>")
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>")

-- Keybindings for tpope commentary plugin
map("n", "\\\\", "<Plug>CommentaryLine")
map("x", "\\\\", "<Plug>Commentary")

-- enable <CR> to work wirh coc (autocompletion plugin)
map("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : \"\\<CR>\"", { expr = true, noremap = true })
