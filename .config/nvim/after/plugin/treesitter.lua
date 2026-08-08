local ensure_installed = {
  "bash", "c", "css", "diff", "html", "javascript", "json",
  "lua", "luadoc", "markdown", "markdown_inline", "python", "query",
  "regex", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml", "php"
}

do
  local ts = require("nvim-treesitter")
  local installed = require("nvim-treesitter.config").get_installed("parsers")
  local missing = vim.iter(ensure_installed)
    :filter(function(p)
      return not vim.tbl_contains(installed, p)
    end)
    :totable()

  if #missing > 0 then
    vim.notify("Installing parsers: " .. table.concat(missing, ", "))
    -- install() is async; wait() blocks so parsers exist before first use.
    ts.install(missing):wait(300000) -- 5 min ceiling
  end
end

-- The rewrite installs parsers and nothing else — features are opt-in per buffer.
-- vim.api.nvim_create_autocmd("FileType", {
--   desc = "Enable treesitter highlighting, indent and folds",
--   callback = function(ev)
--     local ft = vim.bo[ev.buf].filetype
--     local lang = vim.treesitter.language.get_lang(ft)
--     if not lang or not vim.treesitter.language.add(lang) then
--       return -- no parser for this filetype; fall back to regex syntax
--     end
-- 
--     vim.treesitter.start(ev.buf, lang)
-- 
--     -- Indentation is provided by the plugin and still marked experimental.
--     vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
-- 
--     -- Folding comes from Neovim itself, not the plugin.
--     vim.wo[0][0].foldmethod = "expr"
--     vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype

    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then
      return
    end

    local ok_add = pcall(vim.treesitter.language.add, lang)
    if not ok_add then
      return
    end

    pcall(vim.treesitter.start, buf, lang)
  end
})
