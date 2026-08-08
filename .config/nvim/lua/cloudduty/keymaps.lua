vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- keymap selected text without losing the yanked
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without lsoing yanked text" })

-- Delete text without saving it to any register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Unindent and keep selection" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down then center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move down then center" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search cursor centered" })

vim.keymap.set("n", "<leader>re", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

vim.keymap.set("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, { desc = "Toggle builtin undotree" })

-- Floaterm
vim.keymap.set({'n', 't'}, '<C-\\>', '<CMD>FloatermToggle<CR>', { desc = 'Toggle Floaterm' })
vim.keymap.set('n', '<Leader>fn', '<CMD>FloatermNew --height=0.7 --width=0.7 --wintype=float --name=floaterm1 --autoclose=2<CR>', { desc = 'New Floaterm' })
vim.keymap.set({'n', 't'}, '<A-n>', '<CMD>FloatermNext<CR>', { desc = 'Next Floaterm' })
vim.keymap.set({'n', 't'}, '<A-p>', '<CMD>FloatermPrev<CR>', { desc = 'Previous Floaterm' })

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format local buffer" })

-- Git difftools
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
