return {
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- local lspconfig = require("lspconfig")
      -- lspconfig.lua_ls.setup({})
      -- lspconfig.ts_ls.setup({})
      vim.lsp.config("lua_ls", {})
      vim.lsp.config("ts_ls", {})

      vim.lsp.config("solidity_ls_nomicfoundation", {
        -- cmd = { "solidity-language-server", "--stdio" },
        cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
        filetypes = { "solidity" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "hardhat.config.js",
            "foundry.toml",
            ".git"
          )(fname) or vim.fn.getcwd()
        end,
      })

      vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.definition, {})
      -- vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", { silent = true })
      vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true })
      vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, {})


      local function diag_disable()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.diagnostic.enable(false, { bufnr = bufnr })
      end

      local function diag_enable()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.diagnostic.enable(true, { bufnr = bufnr })
      end

      vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {})
      vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {})

      vim.keymap.set("n", "<leader>dd", diag_disable, {})
      vim.keymap.set("n", "<leader>de", diag_enable, {})

      -- vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {})
      -- vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {})
      -- vim.keymap.set("n", "<leader>dd", vim.diagnostic.disable, {})
      -- vim.keymap.set("n", "<leader>de", vim.diagnostic.enable, {})
    end,
  },
}
