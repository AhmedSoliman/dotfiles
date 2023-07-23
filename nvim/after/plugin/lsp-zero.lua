-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
--lsp.setup()

--lsp.preset('recommended')
lsp.extend_lspconfig({
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gy", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'gr', ':FzfLua lsp_references<CR>', { buffer = bufnr, silent = true, noremap = false })
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    --vim.keymap.set("i", "<C-f>", function() vim.lsp.buf.format({ async = true }) end, opts)

    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  end
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    -- Replace these with the servers you want to install
    'rust_analyzer',
    'tsserver',
    'eslint',
  }
})

require('mason-lspconfig').setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({})
  end,
})

-- Diagnostics
lsp.nvim_workspace()
vim.diagnostic.config(lsp.defaults.diagnostics({
  virtual_text = true
}))

require('lsp-zero').set_sign_icons()


--lsp.skip_server_setup({ 'rust_analyzer' })

-- Fix Undefined global 'vim'
require('luasnip').config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})


-- Initialize rust_analyzer with rust-tools
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
