return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    { '<leader>xq', desc = 'Quickfix list' },
    { '<leader>xd', desc = 'Diagnostics' },
    { '<leader>xl', desc = 'Location list' },
  },
  config = function()
    require('trouble').setup {
      icons = {
        indent = { top = '', middle = '', last = '' },
      },
    }

    vim.keymap.set('n', '<leader>xq', '<cmd>Trouble quickfix toggle<cr>')
    vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle<cr>')
    vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist toggle<cr>')
  end,
}
