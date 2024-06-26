local set = vim.opt
local keymap = vim.keymap.set

-- Basic settings
vim.g.mapleader = " " -- Set leader key to space

set.number = true -- Show line numbers
set.expandtab = true -- Use spaces instead of tabs

-- More natural splitting
set.splitbelow = true
set.splitright = true

set.ignorecase = true
set.smartcase = true
set.wildignorecase = true

set.scrolloff = 5
set.undofile = true -- Enable persistent undo
set.swapfile = false -- Disable swap files

-- set.lazyredraw = true -- Don't redraw while executing macros

-- Tabs settings
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2

set.termguicolors = true
set.cursorline = true
set.updatetime = 800 -- Reduce time before CursorHold event fires
set.completeopt = "menu,menuone,noselect" -- Set completeopt to have a better completion experience
set.shortmess:append({ c = true }) -- Avoid showing message extra message when using completion

-- Mouse
set.mouse = "n" -- Enable mouse support
keymap("n", "<LeftDrag>", "<LeftMouse>") -- Prevent mouse drag from visually selecting lines

-- Session management
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Make these commonly mistyped commands still work
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("Wqa", "wqa", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})

if vim.fn.executable("rg") == 1 then
  set.grepprg = "rg --smart-case --vimgrep $*"
  set.grepformat = "%f:%l:%c:%m"
end

-- Remap keys
-- Use hh to escape
keymap({ "i", "x" }, "hh", "<esc>")
keymap("i", "hH", "<esc>")
keymap("t", "<esc>", "<C-\\><C-n>")
keymap("t", "hh", "<C-\\><C-n>")
keymap("c", "hh", "<C-c>")

-- Quickfix and location list navigation
keymap("n", "[q", ":cprev<cr>", { silent = true })
keymap("n", "]q", ":cnext<cr>", { silent = true })
keymap("n", "[Q", ":cfirst<cr>", { silent = true })
keymap("n", "]Q", ":clast<cr>", { silent = true })
keymap("n", "[l", ":lprev<cr>", { silent = true })
keymap("n", "]l", ":lnext<cr>", { silent = true })
keymap("n", "[L", ":lfirst<cr>", { silent = true })
keymap("n", "]L", ":llast<cr>", { silent = true })

-- === Splits === "
-- Navigate between splits using <leader>[hjkl]
keymap("n", "<leader>h", "<C-w>h")
keymap("n", "<leader>j", "<C-w>j")
keymap("n", "<leader>k", "<C-w>k")
keymap("n", "<leader>l", "<C-w>l")
keymap("n", "<leader>=", "<C-w>=") -- Equalize all split sizes

-- Create splits with <leader>[-|] (they look like the split they create)
keymap("n", "<leader>|", ":vsplit<cr>", { silent = true })
keymap("n", "<leader>-", ":split<cr>", { silent = true })

-- Repeat dot actions and macros on visual selection
keymap("x", ".", ":norm.<cr>", { silent = true })
keymap("x", "@@", ":norm!@@<cr>", { silent = true })

-- Rename word under cursor
keymap("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")
keymap("n", "<leader>rn", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")

-- === Spell Check ==="
-- Pressing <leader>ss will toggle and untoggle spell checking
keymap("n", "<leader>ss", ":setlocal spell!<cr>", { silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})

-- === Misc. === --
keymap("n", "<leader><leader>", ":nohlsearc<cr>", { silent = true }) -- Quickly turn off highlighting for a search
keymap("n", "<leader>*", ":grep <C-r><C-w><cr>:cope<cr>", { silent = true }) -- Search codebase for word under cursor

-- === Yank and Paste ===
-- Yank to system clipboard --
keymap({ "n", "v" }, "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+y$')

-- Paste from system clipboard
keymap({ "n", "v" }, "<leader>p", '"+p')
keymap("n", "<leader>P", '"+P')

-- Use rdm in codespaces
if os.getenv("CODESPACES") then
  vim.g.clipboard = {
    name = "rdm",
    copy = {
      ["+"] = { "rdm", "copy" },
      ["*"] = { "rdm", "copy" },
    },
    paste = {
      ["+"] = { "rdm", "paste" },
      ["*"] = { "rdm", "paste" },
    },
  }
end

-- Plugins
require("plugins")
vim.cmd([[colorscheme onenord]])

-- === vim-fugitive === --
keymap("n", "<leader>g", ":Git<cr>", { silent = true })

-- === nvim-bufferline === --
-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
keymap("n", "[b", ":BufferLineCyclePrev<cr>", { silent = true })
keymap("n", "]b", ":BufferLineCycleNext<cr>", { silent = true })
keymap("n", "<leader>bd", ":BufferLinePickClose<cr>", { silent = true })

-- === nvim-tree === --
keymap("n", "<C-n>", ":NvimTreeFindFile<cr>", { silent = true })
keymap("n", "<leader>n", ":NvimTreeToggle<cr>", { silent = true })

-- === vim-matchup === --
vim.cmd([[highlight MatchParen ctermfg=red ctermbg=NONE guifg='#B48EAD' guibg=NONE]]) -- Colour matching parenthesis
