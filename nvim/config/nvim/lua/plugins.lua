local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Automatically compile Packer on write
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim") -- packer can manage itself

  -- Colour palate
  use("rmehri01/onenord.nvim")

  -- UI Elements
  use({
    "kyazdani42/nvim-web-devicons",
    config = [[require('config.devicons')]],
  })
  use({
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = [[require('config.bufferline')]],
  })
  -- Statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = [[require('config.lualine')]],
  })
  -- File tree navigation
  use({
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    config = [[require('config.treesitter')]],
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter/nvim-treesitter",
  })

  -- Show indentation levels
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = [[require('config.indent_blankline')]],
  })

  -- Git utilities
  use({
    "tpope/vim-fugitive",
    requires = "tpope/vim-rhubarb",
  })
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "tpope/vim-repeat", "tpope/vim-fugitive" },
    config = [[require('config.gitsigns')]],
  })

  -- Quick fix list enhancements
  use("stefandtw/quickfix-reflector.vim")

  -- Vim bookmarks plugin
  use("MattesGroeger/vim-bookmarks")

  -- LSP and auto-completion
  -- Snippets
  use({
    "L3MON4D3/LuaSnip",
    requires = "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  })

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
    },
    config = [[require('config.cmp')]],
  })

  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  })
  use({
    "neovim/nvim-lspconfig",
    config = [[require('config.lsp')]],
  })

  use("github/copilot.vim")
  use({
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  })
  use({
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim",
  })

  -- User defined text objects
  use({
    "nelstrom/vim-textobj-rubyblock",
    requires = "kana/vim-textobj-user",
  })

  -- Enhance parenthesis matching
  use("andymass/vim-matchup")

  -- Floating terminal
  use({
    "akinsho/toggleterm.nvim",
    config = [[require('config.toggleterm')]],
  })

  --[[ === Trial plugins === ]]
  -- Colour
  use({
    "norcalli/nvim-colorizer.lua",
    config = [[require('colorizer').setup()]],
  })

  -- Session management
  use({
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "/", "~/Downloads" },
        pre_save_cmds = { "tabdo NvimTreeClose" },
      })
    end,
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim" },
    config = [[require('config.telescope')]],
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Test
  -- use 'AndrewRadev/splitjoin.vim'
  use({
    "ggandor/lightspeed.nvim",
    requires = "tpope/vim-repeat",
  })

  use({
    "folke/which-key.nvim",
    config = [[require('config.which_key')]],
  })

  use({
    "numToStr/Comment.nvim",
    config = [[require('Comment').setup()]],
  })

  use({
    "folke/noice.nvim",
    config = function()
      require("noice").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
