-- Plugins (Lazy-Nvim Plugin Manager)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

 
local plugins = {
  'vifm/vifm.vim',        -- File Manager 
  'mattn/emmet-vim',      -- emmet html - css workflow
  'tpope/vim-surround',   -- Manage surroundings " ' ( [ {  etc..
  'tpope/vim-endwise',    -- end some keywords for you like: def, if... 
  'tpope/vim-commentary', -- Comment with keybinds
  'ap/vim-css-color',     -- Syntax Highlighting and Colors --
  {'neoclide/coc.nvim', branch = 'release', run = 'npm ci'}, -- autocompletion for lang server

  -- Statusline
  {'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = { 
      theme = 'solarized_dark',
    },
  },
  
   -- Telescope
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-treesitter/nvim-treesitter',

  -- Emoji Plugins --
  'junegunn/vim-emoji',

  -- Colorschemes --
  'RRethy/nvim-base16',
  'eriedaberrie/colorscheme-file.nvim', -- instant colorscheme
}

local opts = {}

require("lazy").setup(plugins, opts)
