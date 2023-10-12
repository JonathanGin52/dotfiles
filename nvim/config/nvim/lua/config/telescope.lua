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

keymap("n", "<leader>t", builtins.find_files, { silent = true })
keymap("n", "<leader>gr", builtins.live_grep, { silent = true })
keymap("n", "<leader>b", builtins.buffers, { silent = true })
keymap("n", "<C-s>", require("auto-session.session-lens").search_session, { silent = true, noremap = true })
keymap("n", "<leader>fb", "<Cmd>Telescope bookmarks list<CR>", { silent = true, noremap = true })
