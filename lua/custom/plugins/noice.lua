return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        background_colour = '#282a36',
      },
    },
  },
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  },
  config = function(_, opts)
    require('noice').setup(opts)

    -- Dracula colors: yellow border, transparent bg
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopup', { bg = 'NONE', fg = '#f8f8f2' })
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { fg = '#f1fa8c' })
    vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { fg = '#f1fa8c' })
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitle', { fg = '#f1fa8c', bold = true })
    vim.api.nvim_set_hl(0, 'NoiceConfirm', { bg = 'NONE', fg = '#f8f8f2' })
    vim.api.nvim_set_hl(0, 'NoiceConfirmBorder', { fg = '#f1fa8c' })
  end,
}
