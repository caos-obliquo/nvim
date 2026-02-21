-- Spectre: Search and replace across files
return {
  'nvim-pack/nvim-spectre',
  cmd = 'Spectre',
  keys = {
    { '<leader>S', '<cmd>lua require("spectre").toggle()<cr>', desc = 'Toggle Spectre' },
  },
  opts = {},
}
