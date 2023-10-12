local telescope = require("telescope")

telescope.load_extension("fzf")
telescope.load_extension('bookmarks')
telescope.setup({
  defaults = {
    file_ignore_patterns = { "rbi", "node_modules" },
  },
})
