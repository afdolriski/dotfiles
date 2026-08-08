--------------------------------------------------------------------------
-- Telescope
--------------------------------------------------------------------------
local telescope = require("telescope")
local actions = require("telescope.actions")

local fd = vim.fn.executable("fd") == 1 and "fd" or "fdfind"

telescope.setup({
  defaults = {
    -- ripgrep invocation used by live_grep / grep_string
    vimgrep_arguments    = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!**/.git/*",
    },
    selection_caret      = "❯ ",
    entry_prefix         = "  ",
    path_display         = { "truncate" },
    sorting_strategy     = "ascending",
    layout_strategy      = "horizontal",
    layout_config        = {
      horizontal = { prompt_position = "top", preview_width = 0.55 },
      width = 0.9,
      height = 0.85,
    },
    file_ignore_patterns = {
      "%.git/",
      "%.claude/",
      "%.skills/",
      "%.playwright-mcp/",
      "node_modules/",
      "%.lock$"
    },
    mappings             = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-u>"] = false, -- let <C-u> clear the prompt instead of scrolling preview
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<Esc>"] = actions.close,
      },
      n = {
        ["q"] = actions.close,
      },
    },
  },

  pickers = {
    find_files = {
      find_command = {
        fd,
        "--type=f",
        "--hidden",
        "--strip-cwd-prefix", -- needs fd >= 8.3
        "--exclude=.git",
      },
    },
    live_grep = {
      additional_args = { "--hidden" },
    },
    buffers = {
      sort_lastused = true,
      sort_mru = true,
      mappings = {
        i = { ["<C-d>"] = actions.delete_buffer },
        n = { ["dd"] = actions.delete_buffer },
      },
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

--------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------
local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })
map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>fr", builtin.resume, { desc = "Resume last picker" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search in buffer" })

-- Git
map("n", "<leader>gf", builtin.git_files, { desc = "Git files" })
map("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
map("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })
map("n", "<leader>gs", builtin.git_status, { desc = "Git status" })

-- Search Neovim's own config
map("n", "<leader>fn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find in nvim config" })
