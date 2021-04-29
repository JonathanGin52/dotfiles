" =====================================================
" => General
" =====================================================
set nocompatible                                           " Use vim, not vi
syntax on                                                  " Enable syntax highlighting
filetype on                                                " Enable filetype detection
filetype indent on                                         " Enable filetype-specific indenting
filetype plugin on                                         " Enable filetype-specific plugins
set wildignorecase                                         " Ignore case sensitivity in wildmenu (like tab-completing :commands)
set autoread                                               " Automatically read external changes
set history=500                                            " Sets how many lines of history vim has to remember
set scrolloff=5                                            " Enable always showing 5 lines above/below the cursor position
set undofile

" -----------------------------------------------------
" Enable mouse
" -----------------------------------------------------
set mouse=n
" noremap <LeftDrag> <LeftMouse>
" noremap! <LeftDrag> <LeftMouse>

" More natural splitting
set splitbelow                                             " Open new splits below the current active one
set splitright                                             " Open new splits to the right of the current active one

" Searching
set ignorecase                                             " Ignore case in search
set smartcase                                              " But case-sensitive if expression contains a capital letter
set incsearch                                              " Show matches while typing

" -----------------------------------------------------
" Tabs and spaces
" -----------------------------------------------------
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab                                              " Turns tabs into spaces

" =====================================================
" => UI
" =====================================================
set number                                                 " Show line numbers
set showcmd                                                " Show the command as it's typed
set lazyredraw                                             " Don't redraw the screen while exectuting macros
set cursorline                                             " Highlight the line the cursor is on

" -----------------------------------------------------
" Colourscheme
" -----------------------------------------------------
if (has("termguicolors"))
  set termguicolors
endif

" -----------------------------------------------------
" Statusline
" -----------------------------------------------------
let g:currentmode={
  \ 'n'  : 'N ',
  \ 'no' : 'N·Operator Pending ',
  \ 'v'  : 'V ',
  \ 'V'  : 'V·Line ',
  \ "\<C-v>" : 'V·Block ',
  \ 's'  : 'Select ',
  \ 'S'  : 'S·Line ',
  \ "\<C-s>"  : 'S·Block ',
  \ 'i'  : 'I ',
  \ 'R'  : 'R ',
  \ 'Rv' : 'V·Replace ',
  \ 'c'  : 'Command ',
  \ 'cv' : 'Vim Ex ',
  \ 'ce' : 'Ex ',
  \ 'r'  : 'Prompt ',
  \ 'rm' : 'More ',
  \ 'r?' : 'Confirm ',
  \ '!'  : 'Shell ',
  \ 't'  : 'Terminal '
\}

set laststatus=2                                           " Show statusline
set statusline=%*\ %{toupper(g:currentmode[mode()])}       " Current mode
"set statusline+=%8*\ [%n]                                 " Buffer number
set statusline+=%*\ %{GitInfo()}                           " Git Branch name
set statusline+=%*\ %<%f                                   " File path
set statusline+=%{&readonly?'\ \ ':'\ \ '}                " Read-only flag
set statusline+=%{&modified?'\ ✎':''}                      " Modified flag
set statusline+=%=                                         " Split between left and right side items
set statusline+=%{gutentags#statusline()}\                 " ctags generation progress
set statusline+=%*\ %y                                     " FileType
"set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\  " Encoding & Fileformat
set statusline+=%4l,%-4v                                   " Row of cursor, column of curson
set statusline+=%3p%%\ \                                   " Percentage through the file

" -----------------------------------------------------
" Quick fix list
" -----------------------------------------------------
set grepprg=rg\ --smart-case\ --glob\ '!*.rbi'\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>

" =====================================================
" => Custom mappings
" =====================================================
" -----------------------------------------------------
" Keymaps
" -----------------------------------------------------
" Set leader key to <space>
let mapleader="\<Space>"

" Use hh to escape
inoremap hh <esc>
inoremap hH <esc>
xnoremap hh <esc>
cnoremap hh <C-c>

xnoremap . :norm.<CR>
xnoremap @@ :norm! @@<CR>

" Deal with the system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P

" Toggle between absolute line numbers and hybrid line numbers
nnoremap <silent> <leader>l :LineNumberToggle<cr>

" Display the content of registers
nnoremap <silent> <leader>@ :registers<cr>

" Substitute all occurrences of the word under the cursor
nnoremap <leader>sr :%s/\<<C-r><C-w>\>//g<Left><Left>

nnoremap <leader>rg :Rg <c-r><c-w><cr>

nnoremap <silent> <leader><leader> :nohl<cr>

" -----------------------------------------------------
" Window management
" -----------------------------------------------------
" Create splits with <leader>[-|], they look like the split they create
map <silent> <leader>\| :vsplit<cr>
map <silent> <leader>- :split<cr>

" FZF shortcuts
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>b :Buffers<cr>

" -----------------------------------------------------
" Spell check
" -----------------------------------------------------
" Pressing <leader>ss will toggle and untoggle spell checking
map <silent> <leader>ss :setlocal spell!<cr>

" Next misspelled word
map <leader>sn ]s

" Previous misspelled word
map <leader>sp [s

" Suggestions
map <leader>s? z=

" -----------------------------------------------------
" Window management
" -----------------------------------------------------
" Switch windows
nmap <leader>w <C-w>w

" Resize windows
nmap <leader>= <C-w>=

" -----------------------------------------------------
" Git shortcuts
" -----------------------------------------------------
nmap <leader>gs :Git<cr>gg<c-n>
nnoremap <leader>gd :Gdiff<cr>

" -----------------------------------------------------
" Command maps
" -----------------------------------------------------
" Toggle between absolute linenumbers and hybrid line numbers
command! LineNumberToggle call s:LineNumberToggle()

" Make these commonly mistyped commands still work
command! W w
command! Wq wq
command! Wqa wqa
command! Q q
command! Qa qa

" =====================================================
" => Stuff that does other stuff
" =====================================================
" -----------------------------------------------------
" Functions
" -----------------------------------------------------
" Trim trailing whitespace
function! <SID>TrimTrailingWhitespaces()
    let l=line(".")
    let c=col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Toggle between relative and absolute numbers
function! s:LineNumberToggle() abort
  if (&relativenumber==1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

" Get git information
function! GitInfo()
  let git=fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
  endif
endfunction

" -----------------------------------------------------
" Aucommands
" -----------------------------------------------------
" Trim trailing whitespace on save
autocmd BufWritePre *.rb,*.c,*.java,*.js,*.tsx :call <SID>TrimTrailingWhitespaces()

" Automatically enable spellcheck for markdown files
augroup markdownSpell
  autocmd!
  autocmd FileType markdown setlocal spell
  autocmd BufRead,BufNewFile *.md setlocal spell
augroup END

" =====================================================
" => Plugins
" =====================================================
call plug#begin('~/.vim/plugged')
" UI
Plug 'crispgm/nord-vim' " Fork of nord that provides treesitter support
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Quick fix list enhancements
Plug 'MattesGroeger/vim-bookmarks'
Plug 'stefandtw/quickfix-reflector.vim'

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

" Other
Plug 'w0rp/ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'andymass/vim-matchup'
Plug 'AndrewRadev/splitjoin.vim'
call plug#end()

" -----------------------------------------------------
" Plugin settings
" -----------------------------------------------------
" Nord
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_diff_background = 1
colorscheme nord

let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

" ALE
" Keyboard shortcuts for ALE
map <silent> <leader>t :ALEFix<cr>
map <silent> <leader>td :ALEDetail<cr>
map <silent> <leader>tf :ALELint<cr>

let g:ale_sign_error='● '                                  " Use a solid circle symbol for errors in the sign column
let g:ale_sign_info='‣ '                                   " Use a solid little arrow for 'info' in the sign column
let g:ale_sign_warning='○ '                                " Use a hollow circle symbol for warnings in the sign column
let g:ale_sign_column_always=1                             " Show the sign column even if there are no linter notes

" It may be nice to highlight the actual error here too - drop the 'sign' part
highlight ALEErrorSign        ctermfg=1
highlight ALEWarningSign      ctermfg=3
highlight ALEInfoSign         ctermfg=4
highlight ALEStyleErrorSign   ctermfg=3
highlight ALEStyleWarningSign ctermfg=3
let g:ale_fixers={
\   'ruby': ['rubocop'],
\   'eruby': ['rubocop'],
\   'python': ['black'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['tslint', 'prettier'],
\   'typescriptreact': ['tslint', 'prettier'],
\   'rust': ['rustfmt'],
\}

" Fzf
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

let g:nvim_tree_width = 40
let g:nvim_tree_ignore = [ '.git', 'node_modules' ] "empty by default

nnoremap <silent> <leader>n :NvimTreeFindFile<CR>
nnoremap <silent> <C-n> :NvimTreeToggle<CR>

" Indent line
let g:indentLine_char = '▏'

lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  },
}
require('bufferline').setup {
  options = {
    mappings = true,
    numbers = "ordinal",
  },
}
require "nvim-web-devicons".setup {
  override = {
    html = {
      icon = "",
      color = "#DE8C92",
      name = "html"
    },
    css = {
      icon = "",
      color = "#61afef",
      name = "css"
    },
    js = {
      icon = "",
      color = "#EBCB8B",
      name = "js"
    },
    ts = {
      icon = "ﯤ",
      color = "#519ABA",
      name = "ts"
    },
    git = {
      icon = "",
      name = "git"
    },
    Dockerfile = {
      icon = "",
      color = "#b8b5ff",
      name = "Dockerfile"
    },
    sh = {
      icon = " ",
      color = "#5E81AC",
      name = "sh"
    },
    tags = {
      icon = "",
      color = "nBF616A",
      name = "tags"
    },
    lock = {
      icon = "",
      color = "#BF616A",
      name = "lock"
    },
  }
}
EOF

" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent><leader>j :BufferLineCyclePrev<CR>
nnoremap <silent><leader>k :BufferLineCycleNext<CR>

hi MatchParen ctermfg=red ctermbg=NONE guifg='#B48EAD' guibg=NONE
