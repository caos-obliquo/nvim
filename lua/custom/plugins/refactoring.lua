return {
  'theprimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  cmd = 'Refactor',
  keys = {
    { '<leader>re', desc = 'Extract Function', mode = 'x' },
    { '<leader>rv', desc = 'Extract Variable', mode = 'x' },
  },
  config = function()
    require('refactoring').setup {}

    -- extract function works in visual mode
    vim.keymap.set('x', '<leader>re', function() require('refactoring').refactor 'Extract Function' end)

    -- extract variable works in visual mode
    vim.keymap.set('x', '<leader>rv', function() require('refactoring').refactor 'Extract Variable' end)

    -- inline variable works in normal and visual mode
    vim.keymap.set({ 'n', 'x' }, '<leader>ri', function() require('refactoring').refactor 'Inline Variable' end)

    -- extract block works in normal mode
    vim.keymap.set('n', '<leader>rb', function() require('refactoring').refactor 'Extract Block' end)
  end,
}
