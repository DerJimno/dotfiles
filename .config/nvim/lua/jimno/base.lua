local o = vim.o
local g = vim.g 

o.termguicolors = true
o.number = true
o.relativenumber = true
o.numberwidth = 2
-- o.singcolumn = "yes"
o.cursorline = true
o.clipboard = "unnamedplus"

o.expandtab = true
o.smarttab = true
o.smartindent= true
o.autoindent= true
o.tabstop = 4
o.shiftwidth = 4
o.wrap = true
o.textwidth = 80 
o.softtabstop = -1


o.ignorecase = true
o.smartcase = true

o.history = 50

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false

-- Map <leader> to space
g.mapleader = ","
g.maplocalleader = ","

-- coc node path
g.coc_node_path = '$HOME/.local/share/fnm/node-versions/v22.14.0/installation/bin/node'

-- emmet stuff
g.user_emmet_mode='n'
g.user_emmet_leader_key='<leader>'
