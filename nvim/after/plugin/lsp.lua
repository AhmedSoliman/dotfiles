
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

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
  },
    handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
  },
})

require('lspconfig').lua_ls.setup({
  capabilities = lsp_capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT'
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        }
      }
    }
  }
})

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
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- Outline setup
require("symbols-outline").setup()
