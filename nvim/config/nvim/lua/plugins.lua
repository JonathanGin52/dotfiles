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

  -- Colour theme
  use({
    "rmehri01/onenord.nvim",
    config = function ()
      require("onenord").setup({
        styles = { comments = "italic" },
      })
    end
  })

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
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    after = "onenord.nvim",
    config = [[require('config.lualine')]],
  })

  -- File tree navigation
  use({
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
        filters = { custom = { "^.git$" } },
        view = { width = 40 },
      })
    end,
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
    config = [[require('ibl').setup()]],
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

  -- LSP and auto-completion
  -- Snippets
  use({
    "L3MON4D3/LuaSnip",
    requires = "rafamadriz/friendly-snippets",
    event = "InsertEnter",
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
    cmd = {"Mason"},
  })

  use({
    "neovim/nvim-lspconfig",
    config = [[require('config.lsp')]],
  })

  use({
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
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
    "nvimtools/none-ls.nvim",
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

  -- Vim bookmarks plugin
  use {
    'tomasky/bookmarks.nvim',
    config = function()
      require('bookmarks').setup {
        sign_priority = 8,  --set bookmark sign priority to cover other signs
        save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
        keywords =  {
          ["@t"] = " ", -- mark annotation startswith @t ,signs this icon as `Todo`
          ["@w"] = " ", -- mark annotation startswith @w ,signs this icon as `Warn`
          ["@f"] = " ", -- mark annotation startswith @f ,signs this icon as `Fix`
          ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
        },
        on_attach = function(bufnr)
          local bm = require "bookmarks"
          local map = vim.keymap.set
          map("n","mm",bm.bookmark_toggle) -- add or remove bookmark at current line
          map("n","mi",bm.bookmark_ann) -- add or edit mark annotation at current line
          map("n","mc",bm.bookmark_clean) -- clean all marks in local buffer
          map("n","mn",bm.bookmark_next) -- jump to next mark in local buffer
          map("n","mp",bm.bookmark_prev) -- jump to previous mark in local buffer
          map("n","ml",bm.bookmark_list) -- show marked file list in quickfix window
        end
      }
    end
  }

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim" },
    config = [[require('config.telescope')]],
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  use({
    "ggandor/leap.nvim",
    config = [[require('leap').add_default_mappings()]],
    requires = "tpope/vim-repeat",
  })

  -- use({
  --   "Wansmer/treesj",
  --   requires = { "nvim-treesitter" },
  --   config = function()
  --     require("treesj").setup({ --[[ your config ]]
  --     })
  --   end,
  -- })

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
    config = [[require("noice").setup()]],
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
