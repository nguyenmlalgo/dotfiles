local lint = require("lint")

lint.linters_by_ft = {
  python = { "ruff" }, -- chỉ linting
  lua = { "luacheck" }, -- optional: lint lua nếu bạn muốn
}

-- Tự động lint khi lưu file
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
