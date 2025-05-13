require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Add phpactor to the list of servers
local servers = { "html", "cssls", "eslint", "gopls", "intelephense", "elixirls" }

-- Define a common on_attach function
local function common_on_attach(client, bufnr)
  -- Keybindings for LSP actions
  local buf_set_keymap = function(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
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
            vim.lsp.buf.format { async = false }
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

    if lsp == "html" or lsp == "cssls" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.html", "*.css" },
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end

  -- General LSP setup
  local config = {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- Server-specific settings
  if lsp == "gopls" then
    config.settings = {
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
    }
  elseif lsp == "elixirls" then
    config.cmd = { vim.fn.expand "~/.elixir-ls/release/language_server.sh" }
    config.settings = {
      elixirLS = {
        dialyzerEnabled = false,
        fetchDeps = false,
      },
    }
    config.on_new_config = function(new_config, _)
      local asdf_shims = vim.fn.expand "~/.asdf/shims"
      local asdf_bin = vim.fn.expand "~/.asdf/bin"
      new_config.cmd_env = {
        PATH = asdf_shims .. ":" .. asdf_bin .. ":" .. os.getenv "PATH",
      }
    end
  elseif lsp == "intelephense" then
    config.init_options = {
      storagePath = vim.fn.stdpath "cache" .. "/intelephense",
    }

    config.settings = {
      intelephense = {
        diagnostics = {
          enable = true,
        },
        files = {
          maxSize = 1000000,
        },
        environment = {
          includePaths = {
            "/home/jakob/.config/composer/vendor/jetbrains/phpstorm-stubs",
          },
        },
      },
    }
  elseif lsp == "html" then
    config.settings = {
      html = {
        format = {
          wrapLineLength = 120,
          unformatted = "pre,code,textarea",
        },
      },
    }
  elseif lsp == "cssls" then
    config.settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    }
  end

  -- Setup the LSP
  lspconfig[lsp].setup(config)
end
