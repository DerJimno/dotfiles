return { 
  "ibhagwan/fzf-lua",
  dependencies = {"nvim-tree/nvim-web-devicons"},
  opts = {},
  keys = {
    { "<leader>ff", 
      function() require("fzf-lua").files() end,
      desc="find files in directory"
    }, 

    { "<leader>fg", 
      function() require("fzf-lua").live_grep() end,
      desc="find by grepping in directory"
    },
  },
}
