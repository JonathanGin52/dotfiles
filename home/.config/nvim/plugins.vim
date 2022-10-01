" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
  if executable('curl')
    let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
    if v:shell_error
      echom "Error downloading vim-plug. Please install it manually.\n"
      exit
    endif
  else
    echom "vim-plug not installed. Please install it manually or install curl.\n"
    exit
  endif
endif

call plug#begin('~/.config/nvim/plugged')

" Visual flair
Plug 'kyazdani42/nvim-web-devicons'
Plug 'rmehri01/onenord.nvim'
Plug 'akinsho/nvim-bufferline.lua'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Show indentation levels
Plug 'lukas-reineke/indent-blankline.nvim'

" File tree navigation
Plug 'kyazdani42/nvim-tree.lua'

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git utilities
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'lewis6991/gitsigns.nvim'

" Quick fix list enhancements
Plug 'stefandtw/quickfix-reflector.vim'

" Vim bookmarks plugin
Plug 'MattesGroeger/vim-bookmarks'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" LSP and auto-completion
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'github/copilot.vim'
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'
Plug 'jose-elias-alvarez/null-ls.nvim'

" User defined text objects
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

" Enhance parenthesis matching
Plug 'andymass/vim-matchup'

" Statusline
Plug 'nvim-lualine/lualine.nvim'

" Floating terminal
Plug 'akinsho/toggleterm.nvim'

" === Trial plugins ==="
" Color
Plug 'norcalli/nvim-colorizer.lua'

" Session management
Plug 'rmagatti/auto-session'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Test
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ggandor/lightspeed.nvim'
Plug 'tpope/vim-repeat'
Plug 'folke/which-key.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'rcarriga/nvim-notify'

call plug#end()
