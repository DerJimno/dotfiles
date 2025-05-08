-- Treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "lua", "vim", "ruby", "haskell", "css", "javascript", "html", "python", "bash", "json" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Enter>", -- set to `false` to disable one of the mappings
          node_incremental = "<Enter>", -- Press Enter to incremental select
          scope_incremental = false,
          node_decremental = "<Backspace>", -- Press Backspace to decremental select

        },
      },
    })
  end
}
