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
})

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

