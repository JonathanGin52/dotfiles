require("bufferline").setup {
  options = {
    mappings = true,
    diagnostics = "nvim_lsp",
    numbers = "ordinal",
  },
}

local keymap = vim.keymap.set
keymap("n", "<leader>1", ":lua require('bufferline').go_to_buffer(1, true)<cr>", { silent = true })
keymap("n", "<leader>2", ":lua require('bufferline').go_to_buffer(2, true)<cr>", { silent = true })
keymap("n", "<leader>3", ":lua require('bufferline').go_to_buffer(3, true)<cr>", { silent = true })
keymap("n", "<leader>4", ":lua require('bufferline').go_to_buffer(4, true)<cr>", { silent = true })
keymap("n", "<leader>5", ":lua require('bufferline').go_to_buffer(5, true)<cr>", { silent = true })
keymap("n", "<leader>6", ":lua require('bufferline').go_to_buffer(6, true)<cr>", { silent = true })
keymap("n", "<leader>7", ":lua require('bufferline').go_to_buffer(7, true)<cr>", { silent = true })
keymap("n", "<leader>8", ":lua require('bufferline').go_to_buffer(8, true)<cr>", { silent = true })
keymap("n", "<leader>9", ":lua require('bufferline').go_to_buffer(9, true)<cr>", { silent = true })
keymap("n", "<leader>$", ":lua require('bufferline').go_to_buffer(-1, true)<cr>", { silent = true })
