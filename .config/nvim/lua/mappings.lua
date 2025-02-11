vim.keymap.set("n", "<Esc>", function()
   vim.cmd.nohlsearch()
   vim.cmd.echo()
end)

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(event)
      local opts = { buffer = event.buf }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>r", function() require('nvchad.lsp.renamer')() end, opts)
      vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
   end,
})

vim.keymap.set("n", "<leader>g", ":Neogit<cr>")
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")
vim.keymap.set("n", "<tab>", ":bn<cr>")
vim.keymap.set("n", "<s-tab>", ":bp<cr>")
vim.keymap.set("n", "<leader>m", ":make!<cr>")
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float)
