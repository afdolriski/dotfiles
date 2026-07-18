vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3

-- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })

-- tab
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.foldenable = false

require "theme"
