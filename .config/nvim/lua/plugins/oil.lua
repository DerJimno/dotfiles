return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- Sort file and directory names case insensitive
      case_insensitive = true,
      },
    
    float = {
      -- Padding around the floating window
      padding = 4,
      max_width = 0.9,
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = "right",
    },
  },

  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
