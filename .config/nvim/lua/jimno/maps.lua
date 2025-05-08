local function map(m, k, v, desc, opts)
  opts = opts or {}
  opts.silent = true
  if desc then
    opts.desc = desc
  end
  vim.keymap.set(m, k, v, opts)
end

-- call vifm
map("n", "<leader>vf", "<CMD>Vifm<CR>", "Open vifm Jim")

-- Keybindings for tpope commentary plugin
map("n", "\\\\", "<Plug>CommentaryLine", "Comment/uncomment Line")
map("x", "\\\\", "<Plug>Commentary", "Comment/uncomment selected Line/s")

-- enable <CR> to work wirh coc (autocompletion plugin)
map("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : \"\\<CR>\"", "" , { expr = true, noremap = true })

-- call oil (buffer file manager)
map("n", "-", "<CMD>Oil --float --preview<CR>", "Open Oil File Manager" )

map("n", "gl", function() vim.diagnostic.open_float() end, "Show Diagnostics")
