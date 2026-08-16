-- neovim base16 theme — matugen template. Rendered to
-- ~/.config/nvim/lua/matugen.lua; never edit that file. base00..07 are the
-- Material surface ramp; base08..0F are the shared anchors (see config.toml).

require('base16-colorscheme').setup({
  -- Greyscale ramp, darkest background → lightest foreground. base01 must be
  -- *lighter* than base00 — it is the statusline/linenr shade.
  base00 = "{{colors.surface.default.hex}}",
  base01 = "{{colors.surface_container_low.default.hex}}",
  base02 = "{{colors.surface_container_high.default.hex}}",
  base03 = "{{colors.outline.default.hex}}",
  base04 = "{{colors.on_surface_variant.default.hex}}",
  base05 = "{{colors.on_surface.default.hex}}",
  base06 = "{{colors.on_surface.default.hex | lighten: 6.0}}",
  base07 = "{{colors.on_surface.default.hex | lighten: 12.0}}",

  -- base08 variables / diff deleted        (red)
  base08 = "{{ "#e35b60" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
  -- base09 constants, numbers, booleans    (orange)
  base09 = "{{ "#e0854b" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
  -- base0A types / classes / search bg     (yellow)
  base0A = "{{ "#d9a441" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
  -- base0B strings / diff inserted         (green)
  base0B = "{{ "#6bbf72" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
  -- base0C escapes, regex, support         (cyan)
  base0C = "{{ "#5cbcc4" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
  -- base0D functions / methods / headings  (blue)
  base0D = "{{ "#6fa8ff" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
  -- base0E keywords / storage / diff changed (magenta)
  base0E = "{{ "#c88ce0" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
  -- base0F deprecated / embedded tags      (muted brown)
  base0F = "{{ "#b0704e" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
})


-- base16 covers syntax; the rest of this file is for groups it leaves alone or
-- gets wrong for this palette.

-- Helper function to set multiple highlight groups at once
local function set_hl_mutliple(groups, value)
  for _, v in pairs(groups) do
    vim.api.nvim_set_hl(0, v, value)
  end
end

-- Container + its on_* partner is a background/foreground pair, so this is the
-- one place *_container is correct.
vim.api.nvim_set_hl(0, 'Visual', {
  bg = '{{colors.primary_container.default.hex}}',
  fg = '{{colors.on_primary_container.default.hex}}', -- normal text contrast
})

-- base16 already colours comments base03; this only adds the italics.
set_hl_mutliple({ 'TSComment', 'Comment' }, {
  fg = '{{colors.outline.default.hex}}',
  italic = true,
})

-- Diff colours: the same anchors as the syntax hues, backgrounds pinned to a
-- fixed low lightness so they read as a tint over base00, not a block of colour.
vim.api.nvim_set_hl(0, "DiffAdd", {
  bg = "{{ "#6bbf72" | to_color | harmonize: {{ colors.source_color.default.hex }} | set_lightness: 15.0 }}",
  fg = "{{ "#6bbf72" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
})
vim.api.nvim_set_hl(0, "DiffDelete", {
  bg = "{{ "#e35b60" | to_color | harmonize: {{ colors.source_color.default.hex }} | set_lightness: 15.0 }}",
  fg = "{{ "#e35b60" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
})
vim.api.nvim_set_hl(0, "DiffChange", {
  bg = "{{ "#6fa8ff" | to_color | harmonize: {{ colors.source_color.default.hex }} | set_lightness: 15.0 }}",
  fg = "{{ "#6fa8ff" | to_color | harmonize: {{ colors.source_color.default.hex }} }}",
})
-- DiffText marks the changed span inside a changed line: one step brighter.
vim.api.nvim_set_hl(0, "DiffText", {
  bg = "{{ "#6fa8ff" | to_color | harmonize: {{ colors.source_color.default.hex }} | set_lightness: 26.0 }}",
  fg = "{{ "#6fa8ff" | to_color | harmonize: {{ colors.source_color.default.hex }} | lighten: 10.0 }}",
})
