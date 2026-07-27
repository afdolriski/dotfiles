vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    -- Down
    vim.keymap.set("n", "<Down>", "<Down><CR><c-w>p", { buffer = true, remap = false })
    vim.keymap.set("n", "j", "<Down><CR><c-w>p", { buffer = true, remap = false })

    -- Up
    vim.keymap.set("n", "<Up>", "<Up><CR><c-w>p", { buffer = true, remap = false })
    vim.keymap.set("n", "k", "<Up><CR><c-w>p", { buffer = true, remap = false })
  end,
})
