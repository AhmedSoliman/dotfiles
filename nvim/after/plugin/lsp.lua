vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local function opts(desc)
      return { desc = 'LSP: ' .. desc, buffer = bufnr, remap = false }
    end
    -- Use telescope for lsp navigation
    local builtin = require('telescope.builtin')
    -- Uncomment to disable LSP semantic highlighting if it looks ugly!
    --client.server_capabilities.semanticTokensProvider = nil
    vim.keymap.set("n", "gd", function() builtin.lsp_definitions() end, opts('goto definition'))
    vim.keymap.set("n", "gy", function() builtin.lsp_type_definitions() end, opts('goto type definition'))
    vim.keymap.set("n", "gi", function() builtin.lsp_implementations() end, opts('goto implementation'))

    vim.keymap.set('n', 'gr', function() builtin.lsp_references() end,
      { desc = 'LSP: find references', buffer = bufnr, silent = true, noremap = false })
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts('hover over symbol under cursor'))
    vim.keymap.set("n", "<leader>s", function() builtin.lsp_dynamic_workspace_symbols() end, opts('dynamic LSP symbols'))
    vim.keymap.set("n", "<leader>vd", function() builtin.diagnostics({ bufnr = 0 }) end, opts('local buffer diagnostics'))
    vim.keymap.set("n", "<leader>vwd", function() builtin.diagnostics() end, opts('workspace diagnostics'))
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts('next diagnostic'))
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts('prev diagnostic'))
    vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts('code actions'))
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts('rename'))
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts('signature help'))
    vim.keymap.set("n", "<C-f>", function() vim.lsp.buf.format({ async = true }) end, opts('format code'))

    vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
    vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
  end
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- require('mason').setup({})
-- require('mason-lspconfig').setup({
--   -- ensure_installed = {
--   -- },
--   automatic_enable = true,
--   automatic_installation = true,
--   handlers = {
--     function(server_name)
--       require('lspconfig')[server_name].setup({
--         capabilities = lsp_capabilities,
--       })
--     end,
--   },
-- })

-- require('lspconfig').lua_ls.setup({
--   capabilities = lsp_capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT'
--       },
--       diagnostics = {
--         globals = { 'vim' },
--       },
--       workspace = {
--         library = {
--           vim.env.VIMRUNTIME,
--         }
--       }
--     }
--   }
-- })

-- Fix Undefined global 'vim'
require('luasnip').config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})

local has_words_before = function()
  if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- cmp configuration
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }


local cmp = require('cmp');
local lspkind = require('lspkind')

-- Supermaven
vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })

cmp.setup({
  -- Github Copilot and TAB
  mapping = {
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  },
  sources = {
    -- Github copilot
    { name = "supermaven", group_index = 2 },
    --    { name = "copilot",  group_index = 2 },
    -- Other sources
    { name = "nvim_lsp",   group_index = 2 },
    { name = "path",       group_index = 2 },
    { name = "luasnip",    group_index = 2 },
    {
      name = 'spell',
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return true
        end,
      },
    },
  },
  -- sorting = {
  --   priority_weight = 2,
  --   comparators = {
  --     require("copilot_cmp.comparators").prioritize,
  --
  --     -- Below is the default comparator list and order for nvim-cmp
  --     cmp.config.compare.exact,
  --     cmp.config.compare.offset,
  --     -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
  --     cmp.config.compare.score,
  --     cmp.config.compare.recently_used,
  --     cmp.config.compare.locality,
  --     cmp.config.compare.kind,
  --     cmp.config.compare.sort_text,
  --     cmp.config.compare.length,
  --     cmp.config.compare.order,
  --   },
  -- },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      max_width = 50,
      symbol_map = { Copilot = "", Supermaven = "" }
    })
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})

-- Python setup
-- vim.lsp.config('ruff', {
--   init_options = {
--     settings = {
--       -- Ruff language server settings go here
--     }
--   }
-- })
--
-- vim.lsp.enable('ruff')
vim.lsp.config['basedpyright'] = {
  cmd = { 'basedpyright-langserver', '--stdio' },
  root_markers = { 'pyproject.toml', 'pyrightconfig.json', '.git' },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'standard', -- or "strict"
        autoImportCompletions = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
vim.lsp.enable('basedpyright')

-- Lint / format / organize imports
vim.lsp.config['ruff'] = {
  cmd = { 'ruff', 'server', '--preview' }, -- or just 'ruff-lsp' if you prefer
  root_markers = { 'pyproject.toml', '.git' },
  settings = {
    ruff = {
      -- Let Ruff handle formatting & isort; let BasedPyright handle types
      organizeImports = true,
      fixAll = true,
    },
  },
}
vim.lsp.enable('ruff')
