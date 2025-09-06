require("nvchad.configs.lspconfig").defaults()

local servers = { "pyright", "lua_ls", "html", "cssls" }
vim.lsp.enable(servers)

-- Pyright config
vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        typeCheckingMode = "basic", -- đổi thành "strict" nếu muốn check chặt hơn
      },
    },
  },
})

-- Lua LSP config
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
})
