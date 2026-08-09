---- mini files ----
require("mini.files").setup({
  mappings = {
    go_in = "<CR>",
    go_in_plus = "L",
    go_out = "_",
    go_out_plus = "H",
  }
})

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>-", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

---- mini notify ----
require("mini.notify").setup({
  content = {
    format = function(notif)
      return notif.msg
    end,
  },
})

---- mini cmd completion ----
require("mini.cmdline").setup({
  autocorrect = { enable = false },
})

-- mini surround ----
require("mini.surround").setup()

---- mini extra ----
local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")

MiniPick.setup()
MiniExtra.setup()

vim.keymap.set("n", "<leader>pf", function() MiniPick.builtin.files() end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>xx", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "Mini Picker Grep" })
vim.keymap.set("n", "<leader>xx", function() MiniPick.builtin.help() end, { desc = "Mini Picker Help" })

vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini Picker Diagnostic" })
vim.keymap.set("n", "<leader>pk", function() MiniExtra.pickers.keymaps() end, { desc = "Search keymaps" })

---- mini diff ----
local MiniDiff = require("mini.diff")
MiniDiff.setup({
  source = MiniDiff.gen_source.git()
})

vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive full page new tab" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Fugitive full page new tab" })

---- mini completions ----
local MiniCompletion = require("mini.completion")
MiniCompletion.setup({
  lsp_completion = {
    auto_setup = true,
    process_items = function(items, base)
      return MiniCompletion.default_process_items(items, base, {
        filtersort = "fuzzy",
      })
    end,
  }
})
