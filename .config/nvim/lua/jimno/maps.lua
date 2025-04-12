local function map(m, k, v, opts)
  opts = opts or {}
  opts.silent = true
  vim.keymap.set(m, k, v, opts)
end

-- call vifm
map("n", "<leader>vf", "<CMD>Vifm<CR>")

-- Keybindings for tpope commentary plugin
map("n", "\\\\", "<Plug>CommentaryLine")
map("x", "\\\\", "<Plug>Commentary")

-- enable <CR> to work wirh coc (autocompletion plugin)
map("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : \"\\<CR>\"", { expr = true, noremap = true })

-- call oil (buffer file manager)
map("n", "-", "<CMD>Oil --float --preview<CR>")

map("n", "gl", function() vim.diagnostic.open_float() end) 
