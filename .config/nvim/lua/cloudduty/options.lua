-- lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- others
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode = { 'noselect', 'full' }
vim.opt.path = ".,,"
vim.opt.foldenable = false

-- vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- mini completion
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort,noinsert"
vim.opt.shortmess:append("c")
vim.opt.pumheight = 10
-- mini completion

vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"
vim.o.cmdheight = 0

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  callback = function()
    vim.hl.on_yank()
  end,
})
