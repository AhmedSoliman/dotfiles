local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- **** Styling ****
  -- Rose-pine ColorScheme
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      -- vim.cmd('colorscheme rose-pine')
    end
  })
  use({
    'cocopon/iceberg.vim',
    as = 'iceberg',
    config = function()
      vim.cmd('colorscheme iceberg')
    end
  })
  -- show changed line marks in gutter
  use { 'airblade/vim-gitgutter', branch = "main" }
  -- Icons
  use 'nvim-tree/nvim-web-devicons'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly'                  -- optional, updated every week. (see issue #1193)
  }

  -- Status Line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- **** Navigation ****
  -- Telescope | Fuzzy finder
--  use {
--    'nvim-telescope/telescope-fzf-native.nvim',
--    run = 'make',
--  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = {
      { 'nvim-lua/plenary.nvim' },
--      { 'nvim-telescope/telescope-fzf-native.nvim' },
    }
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

    requires = {
      -- Extended matchers for %
      'andymass/vim-matchup',
      -- Highlight parenthesis pairs w/ different colors
      'p00f/nvim-ts-rainbow',
      -- Auto close <html> tags
      'windwp/nvim-ts-autotag',
    }
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/playground'
  -- UI (Outline)
  use 'simrat39/symbols-outline.nvim'


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

  -- LSP for formatting/diagnostics
  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'lukas-reineke/lsp-format.nvim',
      'nvim-lua/plenary.nvim',
    },
  })

  use({ 'onsails/lspkind.nvim' })


  -- Diagnostics
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        use_diagnostic_signs = true,

        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  -- Lint
  use 'mfussenegger/nvim-lint'
  -- Replace missing colors for LSP
  use('folke/lsp-colors.nvim')
  -- LSP Status
  use { 'j-hui/fidget.nvim',
    tag = "legacy",
    config = function()
      require('fidget').setup {}
    end
  }
  -- Comments
  use {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Rust tools
  use 'simrat39/rust-tools.nvim'

  -- Crates
  use {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  }
  -- for debugging
  use 'mfussenegger/nvim-dap'
  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  use {
    'w0rp/ale',
    ft = { 'ruby', 'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex' },
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- Git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use 'tpope/vim-endwise'
  --use 'rstacruz/vim-closer'

  use {
    'ibhagwan/fzf-lua',
    branch = 'main',
  }

  local utils = require('utils')
  if utils.isModuleAvailable('overlay.plugins') then
    require('overlay.plugins').install_plugins(use)
  end

  -- Github Copilot
  --use 'github/copilot.vim'
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  }

  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  }
end)
