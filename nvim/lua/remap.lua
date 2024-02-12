vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- " Disable Ex mode
vim.keymap.set("n", "Q", "<NOP>", { noremap = true }) -- Use karabiner to fix C-i and Tab problem

vim.keymap.set("n", "<F6>", "<C-i>", { noremap = true }) -- Use karabiner to fix C-i and Tab problem

-- Disable Arrows
vim.keymap.set("", "<Up>", "<NOP>", { noremap = true })
vim.keymap.set("", "<Down>", "<NOP>", { noremap = true })
vim.keymap.set("", "<Left>", "<NOP>", { noremap = true })
vim.keymap.set("", "<Right>", "<NOP>", { noremap = true })

vim.keymap.set("n", "<leader>q", ":qa<CR>")
-- Better j, k, Move by line
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

-- Folding
vim.keymap.set("n", "<tab>", "za", { noremap = true })

vim.keymap.set("n", "<tab>", "za", { noremap = true })

-- Toggle between the last two buffers
vim.keymap.set("n", "<leader><leader>", "<c-^>", { noremap = true })

-- Diagnostics drawer
vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>", { noremap = true })
-- Show floating diagnostics on g?
vim.keymap.set('n', 'g?', vim.diagnostic.open_float, { noremap = true })

-- FZF
-- vim.keymap.set('n', '<C-p>', function()
--   --local utils = require('telescope.utils')
--   local fzf = require('fzf-lua')
--   --local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
--   fzf.files()
-- --  if ret == 0 then
-- --    fzf.git_files()
-- --  else
-- --    fzf.files()
-- --  end
-- end, { silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', function() builtin.find_files() end, { desc = "Find files", silent = true })

vim.keymap.set('n', '<leader>r', function() builtin.resume() end, { desc = "Telescope Resume", silent = true })
vim.keymap.set('n', '<leader>f', ":FzfLua live_grep_native<CR>", { silent = true })
vim.keymap.set('n', '<leader>F', ":FzfLua grep_visual<CR>", { silent = true })
vim.keymap.set('n', '<C-b>', function() builtin.buffers() end, { desc = "Telescope buffers", silent = true })

-- Search results centered please
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })
vim.keymap.set("n", "*", "*zz", { noremap = true, silent = true })
vim.keymap.set("n", "#", "#zz", { noremap = true, silent = true })
vim.keymap.set("n", "g*", "g*zz", { noremap = true, silent = true })

-- Open Outline
vim.keymap.set("", "<F5>", ":SymbolsOutline<CR>", { noremap = true, silent = true })

-- Clear current search highlight by hitten g + /
vim.keymap.set("n", "g/", ":nohlsearch<CR>", { remap = true, silent = true })

-- Better indentation in visual mode (keep selection)
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

-- Move selection in visual mode (J, K)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- Copy to end
vim.keymap.set("n", "Y", "yg$", { remap = true })

-- <leader>p to paste over highlighted but keep register buffer
vim.keymap.set("x", "<leader>p", "\"_dP")


-- LSP Format
-- vim.keymap.set("n", "<C-f>", ":LspZeroFormat<CR>")

-- Powerful replace selected word with <leader>x
vim.keymap.set("n", "<leader>x", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Oil
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>m", ":Oil --float<CR>", { desc = "Open current directory and highlight this file"} )
