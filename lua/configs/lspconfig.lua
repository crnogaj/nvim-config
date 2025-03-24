require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Add phpactor to the list of servers
local servers = { "html", "cssls", "eslint", "gopls", "phpactor" }

-- Define a common on_attach function
local function common_on_attach(client, bufnr)
  -- Keybindings for LSP actions
  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
end

for _, lsp in ipairs(servers) do
  local on_attach = function(client, bufnr)
    -- Apply common logic
    common_on_attach(client, bufnr)

    -- Server-specific logic
    if lsp == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end

    if lsp == "gopls" then
      -- Format on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end

      -- Organize imports on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.code_action {
            context = {
              only = { "source.organizeImports" },
              diagnostics = {},
            },
            apply = true,
          }
          vim.lsp.buf.code_action {
            context = {
              only = { "source.fixAll" },
              diagnostics = {},
            },
            apply = true,
          }
        end,
      })
    end

    if lsp == "phpactor" then
      -- Example: Format PHP files on save (if supported by phpactor)
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end
    end

    if lsp == "html" or lsp == "cssls" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.html", "*.css" },
        callback = function ()
          vim.lsp.buf.format({ async = false })
        end
      })
    end
  end

  -- LSP-specific setup
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = (lsp == "gopls") and {
      gopls = {
        gofumpt = true,
        analyses = {
          unusedparams = true,
          nilness = true,
          shadow = true,
          unusedwrite = true,
        },
        staticcheck = true,
      },
    } or (lsp == "phpactor") and {
      phpactor = {
        indexer = {
          enabled = true,
          include = { "src", "app" }, -- Customize these paths for your project
          exclude = { "vendor", "node_modules" },
        },
      },
    } or (lsp == "html") and {
      html = {
        format = {
          wrapLineLength = 120,
          unformatted = "pre,code,textarea",
        },
      },
    } or (lsp == "cssls") and {
      css = {
        validate = true,
      },
      scss = {
        validate = true,
      },
      less = {
        validate = true,
      },
    } or nil,
  }
end

