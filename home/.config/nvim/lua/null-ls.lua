local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.erb_lint,
    null_ls.builtins.formatting.rubocop,

    null_ls.builtins.diagnostics.eslint,

    null_ls.builtins.completion.spell,

    null_ls.builtins.code_actions.gitsigns,
  },
})
