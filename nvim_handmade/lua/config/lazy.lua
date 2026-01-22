local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Mason: менеджер внешних инструментов (LSP/форматтеры/линтеры/DAP)
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },

  -- Автодополнение
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Форматирование и линт (через внешние инструменты)
  { "stevearc/conform.nvim" },
  { "mfussenegger/nvim-lint" },

  -- Treesitter (подсветка/структура кода)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Поиск/файлы/grep
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Git
  { "lewis6991/gitsigns.nvim" },

  -- UI
  { "nvim-lualine/lualine.nvim" },

  -- DAP (отладка)
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-dap-python" },
})

