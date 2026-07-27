-- lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- colors
-- vim.api.nvim_set_hl(0, "constant", { fg = "#80a0ff", bold = true })
-- vim.api.nvim_set_hl(0, "normal", { bg = "none", ctermbg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })

-- others
vim.g.netrw_banner = 0
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.completeopt = 'menuone,noselect,fuzzy,popup'
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.path = ".,,"
vim.opt.foldenable = false

vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"
vim.o.cmdheight = 0

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking",
    callback = function()
        vim.hl.on_yank()
    end,
})

