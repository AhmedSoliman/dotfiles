-- use vim settings, rather then vi settings (much better!).
-- this must be first, because it changes other options as a side effect.
vim.opt.compatible = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("plugins")
require("asoli")

-- Reminder: If stuck, use vim.cmd("set something")
-- multiline works like this:
-- vim.cmd([[
-- set notimeout
-- set encoding=utf-8
-- ]])

-- Primer
-- vim.g is vim global variables let g:something = ''
-- `vim.opt.something = ''` is equivalent to `set something = ''`
-- vim.o for global options
-- vim.wo for window options
-- vim.bo for buffer options
-- vim.fn for functions vim.fn.thisIsMyFunction()
-- vim.api is collection of API functions.

HOME = os.getenv("HOME")
-- ===============
-- EDITOR SETTINGS
-- ===============
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.timeoutlen = 300
vim.opt.encoding = 'utf-8'
vim.opt.scrolloff = 8 -- Keeps 8 lines visible around the cursor
vim.opt.sidescrolloff = 15 -- Keeps 15 chars to the right on scrolling
vim.opt.visualbell = true
vim.opt.showmode = false
vim.opt.colorcolumn = "81" -- A coloured column at 80 chars
vim.opt.showcmd = true
vim.opt.wrap = false
vim.opt.title = true -- Update terminal title
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.showbreak = "…" -- show ellipsis at breaking
vim.opt.linebreak = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.backupdir = { HOME .. "/.vim-tmp", HOME .. "./tmp", HOME .. "/tmp" }
vim.opt.directory = { HOME .. "/.vim-tmp", HOME .. "./tmp", HOME .. "/tmp" }
vim.opt.termguicolors = true

vim.g.secure_modelines_allowed_items = {
  "textwidth", "tw",
  "softtabstop", "sts",
  "tabstop", "ts",
  "shiftwidth", "sw",
  "expandtab", "et", "noexpandtab", "noet",
  "filetype", "ft",
  "foldmethod", "fdm",
  "readonly", "ro", "noreadonly", "noro",
  "rightleft", "rl", "norightleft", "norl",
  "colorcolumn"
}

-- Undos, TODO: Migrate to lua
vim.cmd([[
  " Let's save undo info!
  if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
  endif
  if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
  endif
]])

vim.opt.undodir = HOME .. "/.vim/undo-dir"
vim.opt.undofile = true
vim.opt.undolevels = 10000 -- max number of changes the can be undone
vim.opt.undoreload = 100000 -- max number of lines to save for undo on a buffer reload

-- My Style
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.laststatus = 2 -- Show Vim status all the time
vim.opt.mouse = "n" -- Mouse in NORMAL mode only, good for copy-pasting
vim.opt.ruler = true
vim.opt.showmatch = true -- Show the matching bracket briefly when we close
vim.opt.list = true
vim.opt.listchars = { nbsp = "¬", extends = "»", precedes = "«", trail = "•" } -- Display tabs and trailing spaces visually
vim.opt.hidden = true -- allow buffers to be hidden before saving
vim.opt.clipboard = "unnamed" -- put contents of unnamed register in OS X clipboard
vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic column
vim.g.tmux_resizer_no_mappings = 0 -- Fix tmux resizing

-- Wrapping Options
-- o.formatoptions = o.formatoptions
--                    + 't'    -- auto-wrap text using textwidth
--                    + 'c'    -- auto-wrap comments using textwidth
--                    + 'r'    -- auto insert comment leader on pressing enter
--                    - 'o'    -- don't insert comment leader on pressing o
--                    + 'q'    -- format comments with gq
--                    - 'a'    -- don't autoformat the paragraphs (use some formatter instead)
--                    + 'n'    -- autoformat numbered list
--                    - '2'    -- I am a programmer and not a writer
--                    + 'j'    -- Join comments smartly
vim.o.formatoptions = vim.o.formatoptions .. 'tcrqnj'

-- Search
vim.opt.incsearch = true -- incremental search
vim.opt.ignorecase = true
vim.opt.smartcase = true -- disable ignorecase if search term has capital letters

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full" -- Configure auto completion in command line
vim.opt.wildignore = { ".hg", ".svn", "*~", "*.png", "*.jpg", "*.gif", "*.settings", "Thumbs.db", "*.min.js", "*.swp",
  "publish/*", "intermediate/*", "*.o", "*.hi", "Zend", "vendor" }

-- Folds
vim.opt.foldlevelstart = 999
vim.opt.foldcolumn = "0"
vim.opt.foldnestmax = 3
vim.opt.foldmethod = "expr"
vim.cmd([[
 set foldexpr=nvim_treesitter#foldexpr()
]])

if vim.fn.has "nvim-0.7" then
  -- highlights yanked text for a little extra visual feedback
  -- so we don't need to rely on visual mode as much, try yip or y4y
  local api = vim.api
  local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
  api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
  })
  -- Windows to close with "q"
  api.nvim_create_autocmd(
    "FileType",
    { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
  )
  api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })


  -- remove superfluous spaces at the end of files
  api.nvim_create_autocmd(
    "BufWritePre",
    { pattern = { "*.c", "*.cpp", "*.py" }, command = [[:%s/\s\+$//e]] }
  )

  -- check if we need to reload the file when it's changed
  api.nvim_create_autocmd(
    "FocusGained",
    { command = [[:checktime]] }
  )

  -- CursorLine gets background
  local cursorLine = api.nvim_create_augroup("CursorLine", { clear = true })
  api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    pattern = "*",
    command = "set cursorline",
    group = cursorLine,
  })
  api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    pattern = "*",
    command = "set nocursorline",
    group = cursorLine,
  })
end

-- Sourcing overlays
vim.cmd([[
  " function to source a file if it exists
  function! SourceIfExists(file)
    if filereadable(expand(a:file))
      exe 'source' a:file
    endif
  endfunction
]])

vim.cmd([[
  " Layered Config
  call SourceIfExists('~/.config/nvim/layers/private/vimrc.vim')
]])
