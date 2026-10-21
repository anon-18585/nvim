 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#1a1b1b',
    base02 = '#161616',
    base03 = '#696969',
    base04 = '#b6afaf',
    base05 = '#f3f2f2',
    base06 = '#f3f2f2',
    base07 = '#f3f2f2',
    base08 = '#fd4663',
    base09 = '#cc6666',
    base0A = '#d65c5c',
    base0B = '#e46767',
    base0C = '#e99696',
    base0D = '#ec9393',
    base0E = '#e99696',
    base0F = '#f4bebe',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f3f2f2',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#696969',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#f3f2f2',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#696969',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#e46767',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#b6afaf',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#e46767' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#d65c5c' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#cc6666' })
  hi('TelescopeSelection',      { fg = '#f3f2f2',          bg = '#161616' })
  hi('TelescopeSelectionCaret', { fg = '#e46767',             bg = '#161616' })
  hi('TelescopeMatching',       { fg = '#e46767',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f3f2f2',          bg = '#000000' })
  hi('MiniPickBorder',         { fg = '#696969',             bg = '#000000' })
  hi('MiniPickPrompt',   { fg = '#f3f2f2',          bg = '#000000' })
  hi('MiniPickPromptPrefix',   { fg = '#e46767',             bg = '#000000' })
  hi('MiniPickBorderText',    { fg = '#000000',             bg = '#e46767' })
  hi('MiniPickMatchCurrent',      { fg = '#f3f2f2',          bg = '#161616' })
  hi('MiniPickPromptCaret', { fg = '#e46767',             bg = '#161616' })
  hi('MiniPickMatchRanges',       { fg = '#e46767',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
