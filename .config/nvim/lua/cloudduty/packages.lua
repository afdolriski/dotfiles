--------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/voldikss/vim-floaterm" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

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

-- latest
vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Build native plugin components",
  callback = function(ev)
    local d = ev.data
    if d.kind == "delete" then
      return
    end

    -- fzf-native ships as C source and must be compiled.
    if d.spec.name == "telescope-fzf-native.nvim" then
      vim.notify("Building telescope-fzf-native...")
      local res = vim.system({ "make" }, { cwd = d.path }):wait()
      if res.code ~= 0 then
        vim.notify("fzf-native build failed:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
      else
        vim.notify("telescope-fzf-native built.")
      end
    end

    if d.spec.name == "nvim-treesitter" then
      if not d.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.notify("Updating treesitter parsers ...")
      require("nvim-treesitter").update():wait(300000)
    end
  end,
})

