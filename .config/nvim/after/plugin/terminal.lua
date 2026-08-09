vim.keymap.set({'n', 't'}, '<C-\\>', '<CMD>FloatermToggle<CR>', { desc = 'Toggle Floaterm' })
vim.keymap.set('n', '<Leader>fn', '<CMD>FloatermNew --height=0.7 --width=0.7 --wintype=float --name=floaterm1 --autoclose=2<CR>', { desc = 'New Floaterm' })
vim.keymap.set({'n', 't'}, '<A-n>', '<CMD>FloatermNext<CR>', { desc = 'Next Floaterm' })
vim.keymap.set({'n', 't'}, '<A-p>', '<CMD>FloatermPrev<CR>', { desc = 'Previous Floaterm' })

