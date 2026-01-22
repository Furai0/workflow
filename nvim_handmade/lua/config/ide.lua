-- Базовые опции
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Диагностика
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded" },
})

-- Mason
require("mason").setup()

-- LSP через mason-lspconfig
require("mason-lspconfig").setup({
  ensure_installed = { "pyright" },
})

local lspconfig = require("lspconfig")

-- capabilities для nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)

  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
  map("n", "<leader>e", vim.diagnostic.open_float)
end

-- Pyright
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "lua", "json", "toml", "yaml", "markdown" },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Telescope
require("telescope").setup({})
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { silent = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { silent = true })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true })

-- Gitsigns
require("gitsigns").setup()

-- Lualine
require("lualine").setup({ options = { theme = "auto" } })

-- Форматирование (Black) через conform
require("conform").setup({
  formatters_by_ft = {
    python = { "black" },
  },
  format_on_save = function(bufnr)
    return { timeout_ms = 2000, lsp_fallback = true }
  end,
})
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { silent = true })

-- Линт (Ruff) через nvim-lint
local lint = require("lint")
lint.linters_by_ft = {
  python = { "ruff" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})

-- DAP Python (debugpy)
local dap_python = require("dap-python")
-- mason ставит debugpy как виртуальное окружение внутри mason
-- путь обычно такой:
dap_python.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

-- DAP keymaps
local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue, { silent = true })
vim.keymap.set("n", "<F10>", dap.step_over, { silent = true })
vim.keymap.set("n", "<F11>", dap.step_into, { silent = true })
vim.keymap.set("n", "<F12>", dap.step_out, { silent = true })
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { silent = true })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { silent = true })

