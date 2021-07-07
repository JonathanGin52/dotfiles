set nocompatible
source ~/.config/nvim/plugins.vim

" Set leader key to <space>
let mapleader="\<Space>"

" ============================================================================ "
" ===                              EDITOR                                  === "
" ============================================================================ "

" === Tabs and spaces === "
set tabstop=2 softtabstop=2 shiftwidth=2                   " Let tabs be 2 spaces wide
set expandtab                                              " Turns tabs into spaces

" === Mouse mode === "
set mouse=n                                                " Enable mouse in Normal mode
" Prevent mouse drag from visually selecting lines
noremap <LeftDrag> <LeftMouse>
noremap! <LeftDrag> <LeftMouse>

" === Splits === "
" More natural splitting
set splitbelow                                             " Open new splits below the current active one
set splitright                                             " Open new splits to the right of the current active one

" === Searching === "
set ignorecase                                             " Ignore case in search
set smartcase                                              " But case-sensitive if expression contains a capital letter
set incsearch                                              " Show matches as characters are entered

" === Completion === "
set completeopt=menuone,noselect                           " Set completeopt to have a better completion experience
set shortmess+=c                                           " Avoid showing message extra message when using completion
"
" === Vim Grep === "
" Use ripgrep when available
if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif

" === Misc. === "
set wildignorecase                                         " Ignore case sensitivity in wildmenu (like tab-completing :commands)
set lazyredraw                                             " Don't redraw the screen while executing macros
set updatetime=800                                         " Reduce time before CursorHold event fires
set hidden                                                 " Allow having unsaved changes in a buffer when navigating away
set undofile
set noswapfile

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" === Interface === "
set number                                                 " Show line numbers
set cursorline                                             " Highlight the current line the cursor is on
set scrolloff=5                                            " Always show 5 lines above/gelow the cursor position

" === Colorscheme === "
if (has('termguicolors'))
  set termguicolors                                        " Enable true color support
endif
let g:nord_italic = 1                                      " Enable italics 
let g:nord_italic_comments = 1                             " Italicize comments
let g:nord_cursor_line_number_background = 1               " Highlight line number column for active line
let g:nord_uniform_diff_background = 1
colorscheme nord

" Highlight yanked text
autocmd TextYankPost * silent! lua require('vim.highlight').on_yank()

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "
 
" === Quality of life === "
" Escape from terminal mode with <esc>
tnoremap <Esc> <C-\><C-n>
" Use hh to escape
inoremap hh <esc>
inoremap hH <esc>
xnoremap hh <esc>
cnoremap hh <C-c>
tnoremap hh <C-\><C-n>
" Make these commonly mistyped commands still work
command! W w
command! Wq wq
command! Wqa wqa
command! Q q
command! Qa qa

" === Yank and Paste === "
" Make Y behave like D
nnoremap Y y$
" Yank to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
" Paste from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P

" === Quickfix & Location List === "
" List navigation
nnoremap <silent>[q :cprevious<CR>
nnoremap <silent>]q :cnext<CR>
nnoremap <silent>[Q :cfirst<CR>
nnoremap <silent>]Q :clast<CR>
nnoremap <silent>[l :lprevious<CR>
nnoremap <silent>]l :lnext<CR>
nnoremap <silent>[L :lfirst<CR>
nnoremap <silent>]L :llast<CR>

" === Splits === "
" Cycle splits using <leader>w
nmap <leader>w <C-w>w
" Navigate between splits using <leader>[hjkl]
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
" Normalize all split sizes
nmap <leader>= <C-w>=
" Create splits with <leader>[-|] (they look like the split they create)
map <silent><leader>\| :vsplit<cr>
map <silent><leader>- :split<cr>

" === Spell Check ==="
" Pressing <leader>ss will toggle and untoggle spell checking
map <silent><leader>ss :setlocal spell!<cr>
" Suggestions
map <leader>s? z=

" === Editing === "
" Rename word under cursor
nnoremap <leader>rn :%s/\<<C-r><C-w>\>//g<Left><Left>
" Repeat dot actions and macros on visual selection
xnoremap . :norm.<CR>
xnoremap @@ :norm! @@<CR>

" === Misc. === "
" Quickly turn off highlighting for a search
nnoremap <silent><leader><leader> :nohlsearc<cr>

" ============================================================================ "
" ===                           PLUGIN CONFIG                              === "
" ============================================================================ "
lua <<EOF
require('devicons')
require('treesitter')
require('lsp')
require('statusline')
require('colorizer').setup()
require('gitsigns').setup()
-- require("which-key").setup {}
require('auto-session').setup { pre_save_cmds = {'tabdo NvimTreeClose'} }
require('telescope').setup { defaults = { file_ignore_patterns = {'rbi'} } }
require("bufferline").setup {
  options = {
    mappings = true,
    diagnostics = "nvim_lsp",
    numbers = "ordinal",
  },
}
EOF

" === Telescope === "
" nnoremap <silent><leader>t :Telescope find_files<CR>
" nnoremap <silent><leader>b :Telescope buffers<CR>
nnoremap <silent><leader>g :Telescope live_grep<CR>

" === fzf ==="
nnoremap <silent><leader>t :Files<CR>
nnoremap <silent><leader>b :Buffers<CR>

" === vim-fugitive === "
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gd :Gdiff<cr>

" === nvim-tree === "
let g:nvim_tree_width = 40
let g:nvim_tree_ignore = [ '.git', 'node_modules' ]
nnoremap <silent><C-n> :NvimTreeFindFile<CR>
nnoremap <silent><leader>n :NvimTreeToggle<CR>

" === nvim-bufferline === "
" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent>[b :BufferLineCyclePrev<CR>
nnoremap <silent>]b :BufferLineCycleNext<CR>

" === vim-bookmarks === "
let g:bookmark_auto_save = 1
let g:bookmark_auto_close = 1

" === indent-blankline.nvim === "
let g:indentLine_char = '▏'
let g:indent_blankline_filetype_exclude = ['help']
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_show_first_indent_level = v:false
" Temporary fix for highlighting bug https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
set colorcolumn=99999

" === vim-matchup === "
" Colour matching parenthesis
highlight MatchParen ctermfg=red ctermbg=NONE guifg='#B48EAD' guibg=NONE

" === FTerm.nvim === "
lua require('FTerm').setup()
nnoremap <silent><C-H> :lua require("FTerm").toggle()<CR>
tnoremap <silent><C-H> <C-\><C-n>:lua require("FTerm").toggle()<CR>
