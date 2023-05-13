local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Normal --
-- Better window navigation
map("n", "<C-Left>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-Up>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to right window" })
-- Resize with arrows
map("n", "<A-h>", ":vertical resize +2<CR>", { desc = "Increase window height" })
map("n", "<A-l>", ":vertical resize -2<CR>", { desc = "Decrease window height" })

-- Navigate buffers
map("n", "<S-Left>", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<S-Right>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })

-- Find files and strings
map("n", "<C-p>", ":Telescope find_files<cr>", { desc = "Find files" })

-- Insert --
-- Press jk fast to exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
