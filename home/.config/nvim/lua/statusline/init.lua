local lualine = require('lualine')
local custom_nord = require('lualine.themes.nord')

local function file_location()
  return string.format(' %s:%s', vim.fn.line('.'), vim.fn.col('.'))
end
local function file_percent()
  local percent = math.floor(100 * vim.fn.line('.') / vim.fn.line('$'))
  return string.format('☰ %s%%%%', percent)
end

local colors = {
  nord1  = '#3B4252',
  nord3  = '#4C566A',
  nord5  = '#E5E9F0',
  nord6  = '#ECEFF4',
  nord7  = '#8FBCBB',
  nord8  = '#88C0D0',
  nord10 = '#5E81AC',
  nord12 = '#D08770',
  nord13 = '#EBCB8B',
  nord14 = '#A3BE8C',
}

custom_nord.insert.a.bg = colors.nord14
custom_nord.visual.a.bg = colors.nord13
custom_nord.replace.a.bg = colors.nord12
custom_nord.command = {a = {fg = colors.nord1, bg = colors.nord7, gui = 'bold'}}
custom_nord.terminal = custom_nord.insert

lualine.setup{
  options = {
    theme = 'onenord',
  },
  sections = {
    lualine_b = { { 'filename', symbols = { modified = ' ', readonly = ' ' } } },
    lualine_c = {
      { 'branch', separator = '' },
      { 'diff', left_padding = 0, symbols = { added = ' ', modified = ' ', removed = ' ' } }
    },
    lualine_x = { { 'diagnostics', sources = { 'nvim_diagnostic' } } },
    lualine_y = { 'filetype' },
    lualine_z = { file_location, file_percent },
  },
  inactive_sections = {
    lualine_b = { { 'filename', symbols = { modified = ' ', readonly = ' ' } } },
      
    lualine_c = { { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } } },
    lualine_x = { { 'diagnostics', sources = { 'nvim_diagnostic' } } },
    lualine_y = { 'filetype' },
  },
  extensions = { 'fzf', 'nvim-tree', 'fugitive' },
}
