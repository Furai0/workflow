return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup({
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, noremap = true, silent = true }

          vim.keymap.set("n", "<leader>ai", ":TSToolsAddMissingImports<CR>", opts)
          vim.keymap.set("n", "<leader>ri", ":TSToolsRemoveUnusedImports<CR>", opts)
          vim.keymap.set("n", "gd", ":TSToolsGoToSourceDefinition<CR>", opts)
          -- vim.keymap.set("n", "<leader>rf", ":TSToolsRenameFile<CR>", {})
        end,
      })
    end,
  },
}
