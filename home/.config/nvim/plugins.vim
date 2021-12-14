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

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Show indentation levels
Plug 'lukas-reineke/indent-blankline.nvim'

" Visual flair
Plug 'akinsho/nvim-bufferline.lua'

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

" LSP and auto-completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" User defined text objects
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

" Enhance parenthesis matching
Plug 'andymass/vim-matchup'

" Statusline
Plug 'nvim-lualine/lualine.nvim'
" Plug '~/src/github.com/jonathangin52/lualine.nvim'

" Floating terminal
Plug 'numtostr/FTerm.nvim'

" === Trial plugins ==="
" Color
Plug 'norcalli/nvim-colorizer.lua'

" Session management
Plug 'rmagatti/auto-session'

" Measure Vim's startuptime
Plug 'tweekmonster/startuptime.vim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Test
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

call plug#end()
