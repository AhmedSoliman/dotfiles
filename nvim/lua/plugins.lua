return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Make opening big files easier
  'LunarVim/bigfile.nvim',

  -- better vim.notify
  'rcarriga/nvim-notify',

  -- **** Styling ****
  -- Base16 Themes
  {
    'tinted-theming/tinted-vim'
  },

  -- show changed line marks in gutter
  { 'airblade/vim-gitgutter',     branch = "main" },
  -- Icons
  { 'nvim-tree/nvim-web-devicons' },
  { 'echasnovski/mini.nvim',      version = false },

  -- File explorer
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  -- Status Line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- **** Navigation ****
  -- Telescope | Fuzzy finder
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },

  -- Telescope | DAP extension
  { 'nvim-telescope/telescope-dap.nvim' },

  {
    'nvim-telescope/telescope.nvim',
    version = "*",
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim' },
    }
  },

  -- Save last cursor position
  {
    'ethanholz/nvim-lastplace',
  },
  -- Folds
  {
    'kevinhwang91/nvim-ufo',
    config = function()
      require("ufo").setup()
    end,
    dependencies = {
      'kevinhwang91/promise-async',
    }
  },

  -- For code actions
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
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
  },

  -- **** LSP & Syntax **
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    build = ":TSUpdate",
    -- init = function()
    --   vim.api.nvim_create_autocmd('FileType', {
    --     callback = function()
    --       -- Enable treesitter highlighting and disable regex syntax
    --       pcall(vim.treesitter.start)
    --       -- Enable treesitter-based indentation
    --       vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    --     end,
    --   })
    -- end,
    -- build = function()
    --   local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    --   ts_update()
    -- end,
    dependencies = {
      -- Extended matchers for %
      'andymass/vim-matchup',
      -- Highlight parenthesis pairs w/ different colors
      -- 'p00f/nvim-ts-rainbow',
      -- Auto close <html> tags
      'windwp/nvim-ts-autotag',
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = "main" },
    },
    -- config = function()
    --   local configs = require("nvim-treesitter.configs")
    --
    --   configs.setup({
    --     -- ensure_installed = { "c", "lua", "rust", "vim", "vimdoc", "query", "heex", "javascript", "html" },
    --     -- sync_install = false,
    --     highlight = { enable = true },
    --     indent = { enable = true },
    --   })
    -- end,
    lazy = false,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    branch = "master",
    config = function()
      require("treesitter-context").setup {
        enable = true,        -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 1,        -- How many lines the window should span. Values <= 0 mean no limit.
        multiline_threshold = 2,
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        patterns = {          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
          },
          -- Example for a specific filetype.
          -- If a pattern is missing, *open a PR* so everyone can benefit.
          --   rust = {
          --       'impl_item',
          --   },
        },
        exact_patterns = {
          -- Example for a specific filetype with Lua patterns
          -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
          -- exactly match "impl_item" only)
          -- rust = true,
        },

        -- [!] The options below are exposed but shouldn't require your attention,
        --     you can safely ignore them.

        zindex = 20,     -- The Z-index of the context window
        mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        separator = '-', -- Separator between context and content. Should be a single character string, like '-'.
      }
    end,
    lazy = false,
  },

  -- Enable when needed
  -- use 'nvim-treesitter/playground'
  --
  -- UI (Outline)
  -- 'simrat39/symbols-outline.nvim', -- deprecated
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      -- Example mapping to toggle outline
      { "<F5>", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },

  },

  -- Useful plugin to show you pending keybinds.
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  --     -- LSP Support
  -- { 'neovim/nvim-lspconfig' },
  -- { 'mason-org/mason.nvim' },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        "lua_ls",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      'neovim/nvim-lspconfig' },
  },
  --     -- Autocompletion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  --     -- Snippets
  { 'L3MON4D3/LuaSnip' },
  -- Snippet Collection (Optional)
  { 'rafamadriz/friendly-snippets' },
  -- Additional lua configuration, makes nvim stuff amazing!
  { 'folke/neodev.nvim' },
  -- inlay-hints at line end
  {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    opts = {}, -- required, even if empty
  },


  -- LSP Zero
  -- {
  --   'VonHeikemen/lsp-zero.nvim',
  --   requires = {
  --     -- LSP Support
  --     { 'neovim/nvim-lspconfig' },
  --     { 'williamboman/mason.nvim' },
  --     { 'williamboman/mason-lspconfig.nvim' },
  --
  --     -- Autocompletion
  --     { 'hrsh7th/nvim-cmp' },
  --     { 'hrsh7th/cmp-buffer' },
  --     { 'hrsh7th/cmp-path' },
  --     { 'saadparwaiz1/cmp_luasnip' },
  --     { 'hrsh7th/cmp-nvim-lsp' },
  --     { 'hrsh7th/cmp-nvim-lua' },
  --
  --     -- Snippets
  --     { 'L3MON4D3/LuaSnip' },
  --     -- Snippet Collection (Optional)
  --     { 'rafamadriz/friendly-snippets' },
  --     -- Additional lua configuration, makes nvim stuff amazing!
  --     { 'folke/neodev.nvim' },
  --
  --   }
  -- },

  -- LSP for formatting/diagnostics
  -- {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   dependencies = {
  --     'lukas-reineke/lsp-format.nvim',
  --     'nvim-lua/plenary.nvim',
  --   },
  -- },

  { 'onsails/lspkind.nvim' },

  -- use { 'RRethy/vim-illuminate',
  --   config = function()
  --     require('illuminate').configure({
  --       -- wait 500ms before highlighting
  --       delay = 500,
  --     })
  --   end
  -- }

  -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
  'folke/neodev.nvim',

  -- Diagnostics
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        use_diagnostic_signs = true,
      }
    end
  },
  -- Lint
  'mfussenegger/nvim-lint',
  -- Replace missing colors for LSP
  'folke/lsp-colors.nvim',
  -- LSP Status
  { 'j-hui/fidget.nvim',
    --    tag = "v1.3.0",
  },
  -- Comments
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- Rust tools
  --  use 'simrat39/rust-tools.nvim'
  {
    'mrcjkb/rustaceanvim',
    version = '^9',
    init = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- you can also put keymaps in here
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end,
          settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              rustfmt = {
                --extraArgs = { "+nightly" },
              },
              assist = {
                importGranularity = "module",
                importPrefix = "by_self",
              },
              cargo = {
                loadOutDirsFromCheck = true,
              },
              procMacro = {
                enable = true,
              },
              files = {
                excludeDirs = {
                  "_build",
                  ".dart_tool",
                  ".flatpak-builder",
                  ".git",
                  ".sl",
                  ".gitlab",
                  ".gitlab-ci",
                  ".gradle",
                  ".idea",
                  ".next",
                  ".project",
                  ".scannerwork",
                  ".settings",
                  ".venv",
                  ".sl",
                  "archetype-resources",
                  "bin",
                  "hooks",
                  "node_modules",
                  "po",
                  "screenshots",
                  "target",
                },
              },
              -- checkOnSave = {
              --   -- consider removing if this bloats or caused slow rebuilds
              --   extraArgs={"--target-dir", "/tmp/rust-analyzer-check"}
              -- },
            },
          },
        },
        -- DAP configuration
        dap = {
        },
      }
    end,
    lazy = false,
  },

  -- Crates
  {
    'saecki/crates.nvim',
    tag = 'stable',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  },

  -- Just files
  'NoahTheDuke/vim-just',
  "IndianBoy42/tree-sitter-just",
  -- for debugging
  'mfussenegger/nvim-dap',
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  -- {
  --   'w0rp/ale',
  --   ft = { 'ruby', 'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex' },
  --   cmd = 'ALEEnable',
  --   config = 'vim.cmd[[ALEEnable]]'
  -- },

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  'tpope/vim-endwise',
  --use 'rstacruz/vim-closer'

  {
    'ibhagwan/fzf-lua',
    branch = 'main',
  },
  --   -- Tailwind + TypeScript
  'princejoogie/tailwind-highlight.nvim',
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = function(client)
        -- Formatting is handled by none-ls
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      settings = {
        tsserver_file_preferences = {
          -- includeInlayParameterNameHints = "all",
          -- includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          -- includeInlayFunctionParameterTypeHints = true,
          -- includeInlayVariableTypeHints = true,
          -- includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          -- includeInlayPropertyDeclarationTypeHints = true,
          -- includeInlayFunctionLikeReturnTypeHints = true,
          -- includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  -- Supermaven AI completion
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        -- keymaps = {
        --   accept_suggestion = "<Tab>",
        --   clear_suggestion = "<C-]>",
        --   accept_word = "<C-j>",
        -- },
        -- ignore_filetypes = { cpp = true }, -- or { "cpp", }
        -- color = {
        --   suggestion_color = "#ffffff",
        --   cterm = 244,
        -- },
        log_level = "off",                 -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,           -- disables built in keymaps for more manual control
        condition = function()
          return false
        end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
      })
    end,
  },
  -- Github Copilot
  -- 'github/copilot.vim',
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     })
  --   end,
  -- },
  --
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- },
}



-- local utils = require('utils')
-- if utils.isModuleAvailable('overlay.plugins') then
--   require('overlay.plugins').install_plugins(use)
-- end
