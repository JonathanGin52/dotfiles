local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Indentation tracking
  use {
    'lukas-reineke/indent-blankline.nvim',
    branch = 'lua',
    setup = [[require('config.indentline')]]
  }

  use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Fork of nord-vim that provides treesitter support
  use 'crispgm/nord-vim'

  -- Add snazy icons
  use 'kyazdani42/nvim-web-devicons'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Show indentation levels
  use 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

  -- Visual flair
  use 'akinsho/nvim-bufferline.lua'

  -- File tree navigation
  use 'kyazdani42/nvim-tree.lua'

  -- Fzf
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'

  -- Git utilities
  use 'tpope/vim-fugitive'
  use {
    'tpope/vim-rhubarb',
    requires = { 'tpope/vim-fugitive' },
  }

  -- Quick fix list enhancements
  use 'MattesGroeger/vim-bookmarks'
  use 'stefandtw/quickfix-reflector.vim'

  -- LSP and auto-completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'

  -- User defined text objects
  use 'kana/vim-textobj-user'
  use 'nelstrom/vim-textobj-rubyblock'

  -- Enhance parenthesis matching
  use 'andymass/vim-matchup'

  -- === Trial plugins ===--

  -- Switch between single-line and multi-line forms of code
  use 'AndrewRadev/splitjoin.vim'

  -- Automatically generate tags
  use 'ludovicchabant/vim-gutentags'

-- Statusline
  -- use 'glepnir/galaxyline.nvim'
  use {
    'hoob3rt/lualine.nvim',
    -- '~/src/github.com/jonathangin52/lualine.nvim'
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- Git signs
  use 'mhinz/vim-signify'

  -- Color
  use 'norcalli/nvim-colorizer.lua'

  -- Helper functions
  use 'nvim-lua/plenary.nvim'

  -- Session management
  use 'rmagatti/auto-session'
end)
