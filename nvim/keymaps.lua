local M = {}

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.setup()
  -- Основные
  map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
  map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
  map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

  -- Copy / paste (system clipboard)
  map("n", "<C-v>", '"*p', { desc = "Paste from system clipboard" })
  map("i", "<C-v>", '"*p', { desc = "Paste from system clipboard (insert)" })
  map("v", "<C-c>", '"*y', { desc = "Yank to system clipboard" })
  map("v", "<leader>p", '"_dP', { desc = "Paste without overriding register" })

  -- Save / search highlight
  map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
  map("n", "<C-h>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

  -- Buffers
  map("n", "<A-q>", "<cmd>bnext<CR>", { desc = "Buffer next (Alt-q)" })
  map("n", "<A-v>", "<cmd>bprevious<CR>", { desc = "Buffer previous (Alt-v)" })
  map("n", "<A-w>", "<cmd>bdelete<CR>", { desc = "Buffer delete (Alt-w)" })

  -- NvimTree
  map("n", "<A-e>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree (Alt-e)" })

  -- Telescope / files
  map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>", { desc = "Find files (Ctrl-p)" })
  map("n", "<leader><Tab>", "<cmd>lua require('telescope.builtin').buffers()<CR>", { desc = "List buffers" })
  map("n", "<C-b>", ":%bd|e#|bd#<CR>", { desc = "Close all other buffers" })

  map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", { desc = "Live grep" })
  map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", { desc = "Help tags" })
  map("n", "<leader>fn", "<cmd>lua require('telescope.builtin').git_status()<CR>", { desc = "Git status (telescope)" })

  -- Custom logger (может не работать в терминале: ctrl+alt)
  map("n", "<C-M-l>", "<cmd>lua require('custom.logger').log_var()<CR>", { desc = "Log variable (custom)" })
end

-- LSP маппинги — вызываем из on_attach(bufnr)
function M.lsp(bufnr)
  local function bmap(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  bmap("n", "gh", vim.lsp.buf.hover, { desc = "LSP hover" })
  bmap("n", "gD", vim.lsp.buf.definition, { desc = "LSP definition" })
  bmap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", { desc = "LSP references (telescope)" })
  bmap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
  bmap("n", "<leader>.", vim.lsp.buf.code_action, { desc = "LSP code action" })

  local function diag_disable()
    local b = vim.api.nvim_get_current_buf()
    vim.diagnostic.enable(false, { bufnr = b })
  end
  local function diag_enable()
    local b = vim.api.nvim_get_current_buf()
    vim.diagnostic.enable(true, { bufnr = b })
  end

  bmap("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "Diag next" })
  bmap("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "Diag prev" })
  bmap("n", "<leader>dd", diag_disable, { desc = "Disable diagnostics (buf)" })
  bmap("n", "<leader>de", diag_enable, { desc = "Enable diagnostics (buf)" })
end

return M


