local gl = require 'galaxyline'
local gls = gl.section
local devicons = require 'nvim-web-devicons'
local vcs = require 'galaxyline.provider_vcs'

gl.short_line_list = {'vim-plug', 'NvimTree'}

local function in_git_repo()
  local branch_name = vcs.get_git_branch()

  return branch_name ~= nil
end
-- Gruvbox
local colors = {
  bg = '#3B4252',
  fg = '#88C0D0',
  bright_red = '#BF616A',
  bright_green = '#A3BE8C',
  bright_yellow = '#EBCB8B',
  bright_blue = '#83a598',
  bright_purple = '#B48EAD',
  bright_aqua = '#8FBCBB',
  bright_orange = '#D08770',
  faded_red = '#9d0006',
  faded_yellow = '#b57614',
  faded_blue = '#076678',
  faded_aqua = '#427b58',
  faded_orange = '#af3a03',
}

local mode_map = {
  ['n'] = {'NORMAL', colors.fg, colors.faded_blue},
  ['i'] = {'INSERT', colors.bright_blue, colors.faded_blue},
  ['R'] = {'REPLACE', colors.bright_red, colors.faded_red},
  ['v'] = {'VISUAL', colors.bright_orange, colors.faded_orange},
  ['V'] = {'V·LINE', colors.bright_orange, colors.faded_orange},
  ['c'] = {'COMMAND', colors.bright_yellow, colors.faded_yellow},
  ['s'] = {'SELECT', colors.bright_orange, colors.faded_orange},
  ['S'] = {'S·LINE', colors.bright_orange, colors.faded_orange},
  ['t'] = {'TERMINAL', colors.bright_aqua, colors.faded_aqua},
  ['']= {'V·BLOCK', colors.bright_orange, colors.faded_orange},
  [''] = {'S·BLOCK', colors.bright_orange, colors.faded_orange},
  ['Rv'] = {'VIRTUAL'},
  ['rm'] = {'--MORE'},
}

local sep = {
  right_filled = '', -- e0b2
  left_filled = '', -- e0b0
  right = '', -- e0b3
  left = '', -- e0b1
}

local icons = {
  locker = '', -- f023
  not_modifiable = '', -- f05e
  unsaved = '', -- f0c7
  pencil = '', -- f040
  page = '☰', -- 2630
  line_number = '', -- e0a1
  connected = '', -- f817
  disconnected = '', -- f818
  error = '', -- f658
  warning = '', -- f06a
  info = '', -- f05a
}

local function mode_hl()
  return mode_map[vim.fn.mode()]
end

local function highlight(group, fg, bg, gui)
  local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
  if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
  vim.cmd(cmd)
end

local function buffer_not_empty()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then return true end
  return false
end

local function diagnostic_exists()
  return not vim.tbl_isempty(vim.lsp.buf_get_clients(0))
end

local function wide_enough(width)
  local squeeze_width = vim.fn.winwidth(0)
  if squeeze_width > width then return true end
  return false
end

gls.left[1] = {
  ViMode = {
    provider = function()
      local label, fg, nested_fg = unpack(mode_hl())
      highlight('GalaxyViMode', colors.bg, fg)
      highlight('GalaxyViModeInv', fg, nested_fg)
      highlight('GalaxyViModeNested', colors.fg, nested_fg)
      highlight('GalaxyViModeInvNested', nested_fg, colors.bg)
      highlight('DiffAdd', colors.bright_green, colors.bg)
      highlight('DiffChange', colors.bright_orange, colors.bg)
      highlight('DiffDelete', colors.bright_red, colors.bg)
      return string.format('  %s ', label)
    end,
    separator = sep.left_filled,
    separator_highlight = 'GalaxyViModeInv',
  }
}
gls.left[2] = {
  FileIcon = {
    provider = function()
      local extention = vim.fn.expand('%:e')
      local icon, iconhl = devicons.get_icon(extention)
      if icon == nil then return '' end
      local fg = vim.fn.synIDattr(vim.fn.hlID(iconhl), 'fg')
      local _, _, bg = unpack(mode_hl())
      highlight('GalaxyFileIcon', fg, bg)
      return ' ' .. icon .. ' '
    end,
    condition = buffer_not_empty,
  }
}
gls.left[3] = {
  FileName = {
    provider = function()
      if not buffer_not_empty() then return '' end
      local fname
      if wide_enough(120) then
        fname = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.')
      else
        fname = vim.fn.expand '%:t'
      end
      if #fname == 0 then return '' end
      if vim.bo.readonly then fname = fname .. ' ' .. icons.locker end
      if not vim.bo.modifiable then fname = fname .. ' ' .. icons.not_modifiable end
      if vim.bo.modified then fname = fname .. ' ' .. icons.pencil end
      return ' ' .. fname .. ' '
    end,
    highlight = 'GalaxyViModeNested',
    condition = buffer_not_empty,
  }
}
gls.left[4] = {
  LeftSep = {
    provider = function() return sep.left_filled end,
    highlight = 'GalaxyViModeInvNested',
  }
}
gls.left[5] = {
  Paste = {
    provider = function()
      if vim.o.paste then return 'Paste ' end
      return ''
    end,
    icon = '   ',
    highlight = {colors.bright_red, colors.bg},
  }
}
gls.left[6] = {
  GitIcon = {
    provider = function () return '   ' end,
    condition = in_git_repo,
    highlight = {colors.bright_red, colors.bg},
  }
}
gls.left[7] = {
  GitBranch = {
    provider = function()
      local branch_name = vcs.get_git_branch()
      if (string.len(branch_name) > 28) then
        return string.sub(branch_name, 1, 25).."..."
      end
      return branch_name .. " "
    end,
    condition = in_git_repo,
    highlight = {colors.fg,colors.bg},
  }
}
gls.left[8] = {
  DiffAdd = {
    provider = 'DiffAdd',
    icon = ' ',
    highlight = {colors.bright_green, colors.bg},
  }
}
gls.left[9] = {
  DiffModified = {
    provider = 'DiffModified',
    icon = ' ',
    highlight = {colors.bright_orange, colors.bg},
  }
}
gls.left[10] = {
  DiffRemove = {
    provider = 'DiffRemove',
    icon = ' ',
    highlight = {colors.bright_red, colors.bg},
  }
}

gls.right[1] = {
  LspStatus = {
    provider = function()
      local connected = diagnostic_exists()
      if connected then
        return '  ' .. icons.connected .. '  '
      else
        return ''
      end
    end,
    highlight = {colors.bright_green, colors.bg},
  }
}
gls.right[2] = {
  DiagnosticWarn = {
    provider = function()
      local n = vim.lsp.diagnostic.get_count(0, 'Warning')
      if n == 0 then return '' end
      return string.format(' %s %d ', icons.warning, n)
    end,
    highlight = {colors.bright_yellow, colors.bg},
  }
}
gls.right[3] = {
  DiagnosticError = {
    provider = function()
      local n = vim.lsp.diagnostic.get_count(0, 'Error')
      if n == 0 then return '' end
      return string.format(' %s %d ', icons.error, n)
    end,
    highlight = {colors.bright_red, colors.bg},
  }
}
gls.right[5] = {
  RightSepNested = {
    provider = function() return sep.right_filled end,
    highlight = 'GalaxyViModeInvNested',
  }
}
gls.right[6] = {
  FileType = {
    provider = function() return ' ' .. vim.bo.filetype .. ' ' end,
    condition = has_file_type,
    highlight = 'GalaxyViModeNested',
  }
}
gls.right[7] = {
  RightSep = {
    provider = function() return sep.right_filled end,
    highlight = 'GalaxyViModeInv',
  }
}
gls.right[8] = {
  PositionInfo = {
    provider = function()
      if not buffer_not_empty() or not wide_enough(60) then return '' end
      return string.format('  %s %s:%s ', icons.line_number, vim.fn.line('.'), vim.fn.col('.'))
    end,
    highlight = 'GalaxyViMode',
  }
}
gls.right[9] = {
  PercentInfo = {
    provider = function ()
      if not buffer_not_empty() or not wide_enough(65) then return '' end
      local percent = math.floor(100 * vim.fn.line('.') / vim.fn.line('$'))
      return string.format(' %s %s%s', icons.page, percent, '% ')
    end,
    highlight = 'GalaxyViMode',
    separator = sep.right,
    separator_highlight = 'GalaxyViMode',
  }
}
local short_map = {
  ['vim-plug'] = 'Plugins',
  ['NvimTree'] = 'Explorer',
}

local function has_file_type()
  local f_type = vim.bo.filetype
  return f_type and f_type ~= ''
end

gls.short_line_left[1] = {
  BufferType = {
    provider = function ()
      local label, fg, nested_fg = unpack(mode_hl())
      highlight('GalaxyViMode', colors.bg, fg)
      highlight('GalaxyViModeInv', fg, nested_fg)
      highlight('GalaxyViModeInvNested', nested_fg, colors.bg)
      local name = short_map[vim.bo.filetype] or 'Editor'
      return string.format('  %s ', name)
    end,
    highlight = 'GalaxyViMode',
    condition = has_file_type,
    separator = sep.left_filled,
    separator_highlight = 'GalaxyViModeInv',
  }
}
gls.short_line_left[2] = {
  ShortLeftSepNested = {
    provider = function() return sep.left_filled end,
    highlight = 'GalaxyViModeInvNested',
  }
}
gls.short_line_right[1] = {
  ShortRightSepNested = {
    provider = function() return sep.right_filled end,
    highlight = 'GalaxyViModeInvNested',
  }
}
gls.short_line_right[2] = {
  ShortRightSep = {
    provider = function() return sep.right_filled end,
    highlight = 'GalaxyViModeInv',
  }
}
