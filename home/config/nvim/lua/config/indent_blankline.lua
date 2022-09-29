require('indent_blankline').setup {
  show_first_indent_level = false,
  use_treesitter = true,
  filetype_exclude = {'help'},
  buftype_exclude = {'terminal'},
  show_current_context = true,
  context_char = '┃',
}
