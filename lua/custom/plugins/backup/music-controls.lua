return {
  {
    'AntonVanAssche/music-controls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('music-controls').setup({
        -- use playerctl
        default_player = 'playerctl',
      })

      -- keymaps for music control
      vim.keymap.set('n', '<leader>mp', '<cmd>MusicControls play<cr>', { desc = 'Music Play' })
      vim.keymap.set('n', '<leader>ms', '<cmd>MusicControls stop<cr>', { desc = 'Music Stop' })
      vim.keymap.set('n', '<leader>mn', '<cmd>MusicControls next<cr>', { desc = 'Music Next' })
      vim.keymap.set('n', '<leader>mb', '<cmd>MusicControls prev<cr>', { desc = 'Music Prev' })
      vim.keymap.set('n', '<leader>mt', '<cmd>MusicControls toggle<cr>', { desc = 'Music Toggle' })
    end,
  },
}
