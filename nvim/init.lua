-- use vim settings, rather then vi settings (much better!).
-- this must be first, because it changes other options as a side effect.
vim.opt.compatible = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

require("plugins")
require("options")
require("remap")
require("neovide")

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
