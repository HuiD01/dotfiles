-- markdownlint 统一使用 ~/.config/nvim/markdownlint.jsonc 里的规则
-- （nvim-lint 的检查 和 conform 的保存时修复 都用同一份配置，避免各行其是）
local config = vim.fn.stdpath("config") .. "/markdownlint.jsonc"

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", config, "-" },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        ["markdownlint-cli2"] = {
          args = { "--fix", "--config", config, "$FILENAME" },
        },
      },
    },
  },
}
