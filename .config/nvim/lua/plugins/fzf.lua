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

    { "<leader>fc",
      function() require("fzf-lua").git_commits() end,
      desc="find any commit"
    },

    { "<leader>fb",
      function() require("fzf-lua").builtin() end,
      desc="find any builtin module"
    },

    { "<leader>fh",
      function() require("fzf-lua").helptags() end,
      desc="find neovim help"
    },

    { "<leader>fk",
      function() require("fzf-lua").keymaps() end,
      desc="find your keymaps"
    },
  },
}
