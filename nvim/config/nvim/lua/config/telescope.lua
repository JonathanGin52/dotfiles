local telescope = require("telescope")
local builtins = require("telescope.builtin")
local keymap = vim.keymap.set

telescope.load_extension("fzf")
telescope.load_extension("bookmarks")
telescope.load_extension("session-lens")
telescope.setup({
  defaults = {
    file_ignore_patterns = { "rbi", "node_modules" },
  },
})

keymap("n", "<leader>t", "<Cmd>Telescope<CR>", { silent = true })
keymap("n", "<leader>ff", builtins.find_files, { silent = true })
keymap("n", "<leader>fg", builtins.live_grep, { silent = true })
keymap("n", "<leader>b", builtins.buffers, { silent = true })
keymap("n", "<leader>fb", "<Cmd>Telescope bookmarks list<CR>", { silent = true, noremap = true })
