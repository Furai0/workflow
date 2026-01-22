-- Keymappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Select all text
map("n", "<C-a>", "gg<S-v>G", opts)

-- Copy and paste
map("n", "<C-v>", '"*p', opts)
map("i", "<C-v>", '"*p', opts)
map("v", "<C-c>", '"*y', opts)
map("v", "<leader>p", '"_dP', opts)

-- Save file
map("n", "<C-s>", ":w<CR>", opts)

-- Manage buffers
map("n", "<A-q>", ":bnext<CR>", opts)
map("n", "<A-v>", ":bprevious<CR>", opts)
map("n", "<A-w>", ":bdelete<CR>", opts)

-- NvimTree
map("n", "<A-e>", ":NvimTreeToggle<CR>", opts)

