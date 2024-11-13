require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "eslint", "vuels", "gopls" }
local nvlsp = require "nvchad.configs.lspconfig"
local on_attach = nvlsp.on_attach

for _, lsp in ipairs(servers) do
  if lsp == "eslint" then
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end
  end
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
