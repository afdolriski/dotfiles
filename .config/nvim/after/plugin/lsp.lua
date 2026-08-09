require("mason").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", {
  root_markers = { ".git" },
  capabilities = capabilities
})

-- Per-server overrides. These are MERGED into nvim-lspconfig's lsp/<name>.lua,
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtimes = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true), -- know about `vim`
      },
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "pyright",
  "jsonls",
  "yamlls",
  "bashls",
  "cssls",
  "html",
  "phpactor",
})

vim.diagnostic.config({
  virtual_text = { current_line = true },
  signs = true,
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = true },
})
