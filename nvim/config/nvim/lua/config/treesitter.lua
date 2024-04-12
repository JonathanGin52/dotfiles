require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  ignore_install = { "phpdoc" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "ruby", "python" },
  },
  matchup = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- Capture groups described in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer", -- Currently relying on vim-textobj-rubyblock for block support in Ruby
        ["ie"] = "@block.inner", -- Currently relying on vim-textobj-rubyblock for block support in Ruby
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["ad"] = "@comment.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    }
  },
})
