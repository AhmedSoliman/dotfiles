-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- **** Styling ****
  -- Rose-pine ColorScheme
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })
  -- Icons
  use 'nvim-tree/nvim-web-devicons'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- **** Navigation ****
  -- Telescope | Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  -- For code actions
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'alexghergh/nvim-tmux-navigation', config = function()

    local nvim_tmux_nav = require('nvim-tmux-navigation')

    nvim_tmux_nav.setup {
      disable_when_zoomed = true -- defaults to false
    }

    vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
    vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
    vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
    vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
    vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
    vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

  end
  }

  -- **** LSP & Syntax ***
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/playground'

  -- LSP Zero
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      -- Snippet Collection (Optional)
      { 'rafamadriz/friendly-snippets' },
    }
  }

  -- Diagnostics
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  -- LSP Status
  use { 'j-hui/fidget.nvim', config = function()
    require('fidget').setup {}
  end
  }
  -- Rust tools
  use 'simrat39/rust-tools.nvim'
  -- for debugging
  use 'mfussenegger/nvim-dap'

  -- Git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use 'tpope/vim-endwise'
  use 'rstacruz/vim-closer'


end)
