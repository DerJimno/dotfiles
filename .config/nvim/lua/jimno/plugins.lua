local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

-- Reloads Neovim after whenever you save plugins.lua
vim.cmd([[
    augroup packer_user_config
      autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]])


packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

    -- use("nvim-tree/nvim-web-devicons") 
    -- A better statusline
	use {
      "nvim-lualine/lualine.nvim", -- A better statusline
      requires = {'nvim-tree/nvim-web-devicons', opt = true }
      }
      require('lualine').setup({
          options = {
          theme = "solarized_dark"
          }
      })

	-- File management --
	use("vifm/vifm.vim")

	-- Tim Pope Plugins --
	use("tpope/vim-surround")

	-- Syntax Highlighting and Colors --
	use("ap/vim-css-color")
	-- use("nickeb96/fish.vim")
    
    -- Telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
    use("nvim-treesitter/nvim-treesitter")

	-- Emoji Plugins --
	use("junegunn/vim-emoji")

	-- Colorschemes --
	use("RRethy/nvim-base16")
    use("eriedaberrie/colorscheme-file.nvim") -- instant colorscheme

	if packer_bootstrap then
		packer.sync()
	end
end)

