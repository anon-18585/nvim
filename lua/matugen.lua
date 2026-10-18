 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#11141a',
    base02 = '#1b1e24',
    base03 = '#8c909f',
    base04 = '#c2c6d5',
    base05 = '#e1e2eb',
    base06 = '#e1e2eb',
    base07 = '#e1e2eb',
    base08 = '#ffb4ab',
    base09 = '#f4aeff',
    base0A = '#b1c6f7',
    base0B = '#adc6ff',
    base0C = '#f4aeff',
    base0D = '#adc6ff',
    base0E = '#b1c6f7',
    base0F = '#d8e2ff',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e1e2eb',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#8c909f',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#e1e2eb',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#8c909f',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#adc6ff',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#c2c6d5',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#adc6ff' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#b1c6f7' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#f4aeff' })
  hi('TelescopeSelection',      { fg = '#e1e2eb',          bg = '#1b1e24' })
  hi('TelescopeSelectionCaret', { fg = '#adc6ff',             bg = '#1b1e24' })
  hi('TelescopeMatching',       { fg = '#adc6ff',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e1e2eb',          bg = '#000000' })
  hi('MiniPickBorder',         { fg = '#8c909f',             bg = '#000000' })
  hi('MiniPickPrompt',   { fg = '#e1e2eb',          bg = '#000000' })
  hi('MiniPickPromptPrefix',   { fg = '#adc6ff',             bg = '#000000' })
  hi('MiniPickBorderText',    { fg = '#000000',             bg = '#adc6ff' })
  hi('MiniPickMatchCurrent',      { fg = '#e1e2eb',          bg = '#1b1e24' })
  hi('MiniPickPromptCaret', { fg = '#adc6ff',             bg = '#1b1e24' })
  hi('MiniPickMatchRanges',       { fg = '#adc6ff',             bold = true })
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
