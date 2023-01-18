require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "cpp", "rust", "python", "javascript", "typescript", "dockerfile", "go", "java", "json",
    "markdown", "toml", "yaml", "html", "css", "scss", "vim", "help", "lua" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    --  lint_events = {"BufWrite", "CursorHold"},
  },
}
