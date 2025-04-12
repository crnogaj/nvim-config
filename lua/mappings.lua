require "nvchad.mappings"

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = true
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("i", "jk", "<ESC>", { desc = "Exit to normal from insert mode"})

map("n", "<C-a>", "ggVG", { desc = "Select all"})

map({ "n", "v" }, "<C-c>", '"+y', { desc = "Copy to clipboard"})
map({ "n", "v" }, "<C-x>", '"+d', { desc = "Cut to clipboard"})
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste from clipboard"})

map("n", "L", "v<Right>", { desc = "Enable Shift+l for visual selection in normal mode"})
map("n", "H", "v<Left>", { desc = "Enable Shift+h for visual selection in normal mode"})
map("n", "K", "v<Up>", { desc = "Enable Shift+k for visual selection in normal mode"})
map("n", "J", "v<Down>", { desc = "Enable Shift+j for visual selection in normal mode"})

map("v", "L", "<Right>", { desc = "Continue selection in visual mode with Shift+l"})
map("v", "H", "<Left>", { desc = "Continue selection in visual mode with Shift+h"})
map("v", "K", "<Up>", { desc = "Continue selection in visual mode with Shift+k"})
map("v", "J", "<Down>", { desc = "Continue selection in visual mode with Shift+j"})

map("n", "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "telescope resume last" })

map("n", "cgw", function()
  -- Get the word under the cursor
  local word = vim.fn.expand "<cword>"
  -- Prompt the user for the replacement word
  local replacement = vim.fn.input("Replace '" .. word .. "' with: ")

  -- If the input was canceled with Esc (returns `nil`), cancel the operation
  if replacement == "" then
    print "Replacement canceled"
    return
  end

  -- Run the substitution command using the word and replacement
  vim.cmd(":%s/\\<" .. word .. "\\>/" .. replacement .. "/g")
end, { desc = "Replace all occurences of word under cursor in current file"})

vim.cmd [[
  command! Q q
  command! Qa qa
  command! QA qa
  command! W w
  command! Wq wq
  command! WQ wq
  command! X x
  command! Ra Qfreplace
]]
