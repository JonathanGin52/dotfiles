set nocompatible

" Set leader key to <space>
let mapleader="\<Space>"

" ============================================================================ "
" ===                              EDITOR                                  === "
" ============================================================================ "

" === Tabs and spaces === "
set tabstop=2 softtabstop=2 shiftwidth=2                   " Let tabs be 2 spaces wide
set expandtab                                              " Turns tabs into spaces

" Language specific indentation settings
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4"

" === Mouse mode === "
set mouse=n                                                " Enable mouse in Normal mode
" Prevent mouse drag from visually selecting lines
noremap <LeftDrag> <LeftMouse>
noremap! <LeftDrag> <LeftMouse>

" === Splits === "
" More natural splitting
set splitbelow                                             " Open new splits below the current active one
set splitright                                             " Open new splits to the right of the current active one
set hidden                                                 " Allow switching buffers without saving

" === Searching === "
set ignorecase                                             " Ignore case in search
set smartcase                                              " But case-sensitive if expression contains a capital letter
set incsearch                                              " Show matches as characters are entered

" === Completion === "
set completeopt=menu,noselect                              " Set completeopt to have a better completion experience
set shortmess+=c                                           " Avoid showing message extra message when using completion

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
" Yank to system clipboard
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
vnoremap <leader>y "+y
" Paste from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P

lua <<EOF
if os.getenv("CODESPACES") then
  vim.g.clipboard = {
    name = "rdm",
    copy = {
      ["+"] = {"rdm", "copy"},
      ["*"] = {"rdm", "copy"}
    },
    paste = {
      ["+"] = {"rdm", "paste"},
      ["*"] = {"rdm", "paste"}
    },
  }
end
EOF

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
nnoremap <leader>sr :%s/\<<C-r><C-w>\>//g<Left><Left>
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
require("plugins")
require('nvim-tree').setup {
  view = {width = 40},
}
require('onenord').setup({
  styles = {
    comments = 'italic',
  },
})
vim.cmd [[colorscheme onenord]]
EOF

" === Telescope === "
nnoremap <silent><leader>t :Telescope find_files<CR>
nnoremap <silent><leader>b :Telescope buffers<CR>
nnoremap <silent><leader>g :Telescope live_grep<CR>

" === fzf ==="
" nnoremap <silent><leader>t :Files<CR>
" nnoremap <silent><leader>b :Buffers<CR>

" === vim-fugitive === "
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gd :Gdiff<cr>

" === nvim-tree === "
nnoremap <silent><C-n> :NvimTreeFindFile<CR>
nnoremap <silent><leader>n :NvimTreeToggle<CR>

" === nvim-bufferline === "
" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent>[b :BufferLineCyclePrev<CR>
nnoremap <silent>]b :BufferLineCycleNext<CR>

nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

" === vim-bookmarks === "
let g:bookmark_auto_save = 1
let g:bookmark_auto_close = 1

" === vim-matchup === "
" Colour matching parenthesis
highlight MatchParen ctermfg=red ctermbg=NONE guifg='#B48EAD' guibg=NONE
