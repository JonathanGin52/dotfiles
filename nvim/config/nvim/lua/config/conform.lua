local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    ruby = { "rubocop" },
    eruby = { "erb_format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    go = { "goimports", "gofmt" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    graphql = { "prettier" },
    lua = { "stylua" },
    python = { "isort", "black" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
