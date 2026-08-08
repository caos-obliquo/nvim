local function enable_transparency()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#44475A', bold = true })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#BD93F9', bg = '#44475A', bold = true })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6272A4', bg = 'none' })

  -- floating windows
  vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#BD93F9', bg = 'none' })
  vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#FF79C6', bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })

  -- telescope
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#BD93F9', bg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = '#21222C' })
  vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#21222C', bg = '#21222C' })
  vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = '#FF79C6', bg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = '#50FA7B', bg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = '#8BE9FD', bg = 'none' })

  -- which-key
  vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'WhichKeyBorder', { fg = '#BD93F9', bg = 'none' })

  -- neo-tree
  vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { bg = 'none' })

  -- lsp diagnostics floats
  vim.api.nvim_set_hl(0, 'DiagnosticFloatingError', { fg = '#FF5555', bg = 'none' })
  vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn', { fg = '#FFB86C', bg = 'none' })
  vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo', { fg = '#8BE9FD', bg = 'none' })
  vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint', { fg = '#6272A4', bg = 'none' })

  -- apply jonkero9-inspired syntax highlights for dracula
  require('custom.dracula-syntax').apply()
  -- fidget: lsp progress notifications
  vim.api.nvim_set_hl(0, 'FidgetTitle',   { fg = '#BD93F9', bg = 'none' })
  vim.api.nvim_set_hl(0, 'FidgetTask',    { fg = '#6272A4', bg = 'none' })

  -- lsp info border
  vim.api.nvim_set_hl(0, 'LspInfoBorder', { fg = '#BD93F9', bg = 'none' })

  -- messages
  vim.api.nvim_set_hl(0, 'MsgArea',       { bg = 'none' })
  vim.api.nvim_set_hl(0, 'MsgSeparator',  { bg = 'none' })

  -- window separators
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

    -- re-apply after any colorscheme change
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = enable_transparency,
    })
  end,
}
