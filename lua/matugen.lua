 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#10141d',
    base02 = '#1a1e27',
    base03 = '#8991a5',
    base04 = '#bfc6dc',
    base05 = '#dfe2ef',
    base06 = '#dfe2ef',
    base07 = '#dfe2ef',
    base08 = '#ffb4ab',
    base09 = '#adc6ff',
    base0A = '#84d2e6',
    base0B = '#54d6f3',
    base0C = '#adc6ff',
    base0D = '#54d6f3',
    base0E = '#84d2e6',
    base0F = '#aaedff',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#dfe2ef',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#8991a5',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#dfe2ef',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#8991a5',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#54d6f3',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#bfc6dc',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#54d6f3' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#84d2e6' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#adc6ff' })
  hi('TelescopeSelection',      { fg = '#dfe2ef',          bg = '#1a1e27' })
  hi('TelescopeSelectionCaret', { fg = '#54d6f3',             bg = '#1a1e27' })
  hi('TelescopeMatching',       { fg = '#54d6f3',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#dfe2ef',          bg = '#000000' })
  hi('MiniPickBorder',         { fg = '#8991a5',             bg = '#000000' })
  hi('MiniPickPrompt',   { fg = '#dfe2ef',          bg = '#000000' })
  hi('MiniPickPromptPrefix',   { fg = '#54d6f3',             bg = '#000000' })
  hi('MiniPickBorderText',    { fg = '#000000',             bg = '#54d6f3' })
  hi('MiniPickMatchCurrent',      { fg = '#dfe2ef',          bg = '#1a1e27' })
  hi('MiniPickPromptCaret', { fg = '#54d6f3',             bg = '#1a1e27' })
  hi('MiniPickMatchRanges',       { fg = '#54d6f3',             bold = true })
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
