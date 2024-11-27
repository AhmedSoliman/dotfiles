-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
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

  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
end
)

lsp.set_sign_icons({
  error = "✘",
  warn = "▲",
  hint = "⚑",
  info = "»",
})


require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
  }
})

require('mason-lspconfig').setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({})
  end,
})

require('lsp-zero').set_sign_icons()

-- Fix Undefined global 'vim'
require('luasnip').config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})

-- Initialize rust_analyzer with rust-tools
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

require('rust-tools').setup({
  tools = {
    inlay_hints = {
      auto = true,
    },
  },
  server = {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        rustfmt = {
          extraArgs = { "+nightly" },
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
      },
    },
  }
})


require("lspconfig").clangd.setup {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

require('lspconfig').yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        -- Github actions
        ['https://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
        ['https://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
        -- Stainless schema
        ['./lib/config-schema.json'] = 'specs/*.stainless.yml',
      },
    },
  },
})

require('lspconfig').jsonls.setup({
  settings = {
    json = {
      schemas = {
        {
          description = 'TypeScript compiler configuration file',
          fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
          url = 'http://json.schemastore.org/tsconfig',
        },
        {
          description = 'Babel configuration',
          fileMatch = { '.babelrc.json', '.babelrc', 'babel.config.json' },
          url = 'http://json.schemastore.org/lerna',
        },
        {
          description = 'ESLint config',
          fileMatch = { '.eslintrc.json', '.eslintrc' },
          url = 'http://json.schemastore.org/eslintrc',
        },
        {
          description = 'Prettier config',
          fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },
          url = 'http://json.schemastore.org/prettierrc',
        },
        {
          description = 'Vercel Now config',
          fileMatch = { 'now.json' },
          url = 'http://json.schemastore.org/now',
        },
        {
          description = 'Stylelint config',
          fileMatch = { '.stylelintrc', '.stylelintrc.json', 'stylelint.config.json' },
          url = 'http://json.schemastore.org/stylelintrc',
        },
      },
    },
  },
})

-- Java (auto installer, includes lombok)
require 'lspconfig'.jdtls.setup { cmd = { 'jdtls' } }

-- Tailwind color highlight
local tw_highlight = require('tailwind-highlight')

require('lspconfig').tailwindcss.setup({
  on_attach = function(client, bufnr)
    -- rest of you config
    tw_highlight.setup(client, bufnr, {
      single_column = false,
      mode = 'background',
      debounce = 200,
    })
  end
})

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- cmp configuration
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }


local cmp = require('cmp');
local lspkind = require('lspkind')

local cmp_config = require('lsp-zero').defaults.cmp_config({
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
  },
  sources = {
    -- Github copilot
    { name = "copilot",  group_index = 2 },
    -- Other sources
    { name = "nvim_lsp", group_index = 2 },
    { name = "path",     group_index = 2 },
    { name = "luasnip",  group_index = 2 },
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
  formatting = {
    format = lspkind.cmp_format({
    })
  }
})


cmp.setup(cmp_config)

-- Outline setup
require("symbols-outline").setup()
