require("nvim-treesitter.configs").setup {
  -- Install all maintained parsers
  ensure_installed = "maintained",

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
    disable_filetype = {"python", "ruby"},
  },
  textobjects = {
    select = {
      -- disabling until Ruby support is added. Using vim-textobj-rubyblock for now
      enable = false,
      keymaps = {
        -- Capture groups described in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['ae'] = '@block.outer',
        ['ie'] = '@block.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['is'] = '@statement.inner',
        ['as'] = '@statement.outer',
        ['ad'] = '@comment.outer',
      },
    },
  },
}
