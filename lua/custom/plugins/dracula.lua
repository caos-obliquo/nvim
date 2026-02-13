local function enable_transparency()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#44475A', bold = true })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#BD93F9', bg = '#44475A', bold = true })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6272A4', bg = 'none' })

  -- Floating windows
  vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#BD93F9', bg = 'none' })
  vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#FF79C6', bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })

  -- Telescope
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#BD93F9', bg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = '#21222C' })
  vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#21222C', bg = '#21222C' })
  vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = '#FF79C6', bg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = '#50FA7B', bg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = '#8BE9FD', bg = 'none' })

  -- Which-key
  vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'WhichKeyBorder', { fg = '#BD93F9', bg = 'none' })

  -- Neo-tree
  vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { bg = 'none' })

  -- LSP diagnostics floats
  vim.api.nvim_set_hl(0, 'DiagnosticFloatingError', { fg = '#FF5555', bg = 'none' })
  vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn', { fg = '#FFB86C', bg = 'none' })
  vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo', { fg = '#8BE9FD', bg = 'none' })
  vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint', { fg = '#6272A4', bg = 'none' })

  -- Apply jonkero9-inspired syntax highlights for Dracula
  require('custom.dracula-syntax').apply()
  -- Fidget (LSP progress notifications bottom right)
  vim.api.nvim_set_hl(0, 'FidgetTitle',   { fg = '#BD93F9', bg = 'none' })
  vim.api.nvim_set_hl(0, 'FidgetTask',    { fg = '#6272A4', bg = 'none' })

  -- LSP info border
  vim.api.nvim_set_hl(0, 'LspInfoBorder', { fg = '#BD93F9', bg = 'none' })

  -- Messages
  vim.api.nvim_set_hl(0, 'MsgArea',       { bg = 'none' })
  vim.api.nvim_set_hl(0, 'MsgSeparator',  { bg = 'none' })

  -- Window separators
  vim.api.nvim_set_hl(0, 'WinSeparator',  { fg = '#BD93F9', bg = 'none' })

end

return {
  'Mofiqul/dracula.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('dracula').setup({
      transparent_bg = true,
    })
    vim.cmd.colorscheme('dracula')
    enable_transparency()

    -- Re-apply after any colorscheme change
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = enable_transparency,
    })
  end,
}
