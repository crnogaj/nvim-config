require "nvchad.mappings"

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = true
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Exit to normal from insert mode
map("i", "jk", "<ESC>")

-- Select all
map("n", "<C-a>", "ggVG")

-- Replace word
-- map("n", "<leader>r", "ciw")

-- Copy to clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')

-- Cut to clipboard
map("n", "<leader>d", '"+d')
map("v", "<leader>d", '"+d')

-- Move up/down by one screen
-- map("n", "<C-M-j>", "<C-f>")  -- Scroll down by one screen
-- map("n", "<C-M-k>", "<C-b>")  -- Scroll up by one screen

-- Move 10 lines up/down
map("n", "<M-j>", "10j") -- Move down by 10 lines
map("n", "<M-k>", "10k") -- Move up by 10 lines

-- Move line up
map("n", "<C-M-k>", ":m .-2<CR>==")
map("v", "<C-M-k>", ":m '<-2<CR>gv=gv")
map("i", "<C-M-k>", "<Esc>:m .-2<CR>==gi")

-- Move line down
map("n", "<C-M-j>", ":m .+1<CR>==")
map("v", "<C-M-j>", ":m '>+1<CR>gv=gv")
map("i", "<C-M-j>", "<Esc>:m .+1<CR>==gi")

-- Enable Shift + lhkj for visual selection in normal mode
map("n", "L", "v<Right>")
map("n", "H", "v<Left>")
map("n", "K", "v<Up>")
map("n", "J", "v<Down>")

-- Continue selection in visual mode with Shift + lhkj
map("v", "L", "<Right>")
map("v", "H", "<Left>")
map("v", "K", "<Up>")
map("v", "J", "<Down>")

-- Global replace of word under cursor
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
end)

vim.cmd [[
  command! Q q
  command! Qa qa
  command! QA qa
  command! W w
  command! Wq wq
  command! WQ wq
  command! X x
]]
