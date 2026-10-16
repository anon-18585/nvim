 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#001c33',
    base02 = '#00182c',
    base03 = '#616a71',
    base04 = '#afb3b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#9761d1',
    base0A = '#5c5ed6',
    base0B = '#67a8e4',
    base0C = '#be96e9',
    base0D = '#93c1ec',
    base0E = '#9697e9',
    base0F = '#bebff4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#616a71',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#616a71',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#67a8e4',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#afb3b6',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#67a8e4' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#5c5ed6' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#9761d1' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#00182c' })
  hi('TelescopeSelectionCaret', { fg = '#67a8e4',             bg = '#00182c' })
  hi('TelescopeMatching',       { fg = '#67a8e4',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#000000' })
  hi('MiniPickBorder',         { fg = '#616a71',             bg = '#000000' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#000000' })
  hi('MiniPickPromptPrefix',   { fg = '#67a8e4',             bg = '#000000' })
  hi('MiniPickBorderText',    { fg = '#000000',             bg = '#67a8e4' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#00182c' })
  hi('MiniPickPromptCaret', { fg = '#67a8e4',             bg = '#00182c' })
  hi('MiniPickMatchRanges',       { fg = '#67a8e4',             bold = true })
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
