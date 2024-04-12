local lualine = require("lualine")

local function file_location()
  return string.format(" %s:%s", vim.fn.line("."), vim.fn.col("."))
end

local function file_percent()
  local percent = math.floor(100 * vim.fn.line(".") / vim.fn.line("$"))
  return string.format("☰ %s%%%%", percent)
end

lualine.setup({
  options = {
    theme = "onenord",
  },
  sections = {
    lualine_b = { { "filename", symbols = { modified = " ", readonly = " " } } },
    lualine_c = {
      { "branch", separator = "" },
      { "diff", left_padding = 0, symbols = { added = " ", modified = " ", removed = " " } },
    },
    lualine_x = { { "diagnostics", sources = { "nvim_diagnostic" } } },
    lualine_y = { "filetype" },
    lualine_z = { file_location, file_percent },
  },
  inactive_sections = {
    lualine_b = { { "filename", symbols = { modified = " ", readonly = " " } } },

    lualine_c = { { "diff", symbols = { added = " ", modified = " ", removed = " " } } },
    lualine_x = { { "diagnostics", sources = { "nvim_diagnostic" } } },
    lualine_y = { "filetype" },
  },
  extensions = { "toggleterm", "fzf", "nvim-tree", "fugitive" },
})
