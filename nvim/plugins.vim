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

" Fork of nord-vim that provides treesitter support
Plug 'crispgm/nord-vim'

" Add snazy icons
Plug 'kyazdani42/nvim-web-devicons'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Show indentation levels
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

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

" Quick fix list enhancements
Plug 'MattesGroeger/vim-bookmarks'
Plug 'stefandtw/quickfix-reflector.vim'

" LSP and auto-completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" User defined text objects
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

" Enhance parenthesis matching
Plug 'andymass/vim-matchup'

" === Trial plugins ==="

" Switch between single-line and multi-line forms of code
Plug 'AndrewRadev/splitjoin.vim'

" Automatically generate tags
Plug 'ludovicchabant/vim-gutentags'

call plug#end()
