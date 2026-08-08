-- extra plugins: lazygit, hardtime, render-markdown, zen-mode, surround

return {
  -- lazygit integration
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  -- hardtime: breaks bad vim habits
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      disable_mouse = false,
      max_count = 10,
      disabled_filetypes = {
        'neo-tree',
        'lazy',
        'mason',
        'help',
        'TelescopePrompt',
      },
    },
  },

  -- markdown rendering
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      latex = { enabled = false },
      yaml = { enabled = false },
    },
  },

  -- zen mode: distraction-free coding
  {
    'folke/zen-mode.nvim',
    keys = {
      { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Zen Mode' },
    },
    opts = {
      window = {
        width = 0.85,
        options = {
          number = true,
          relativenumber = true,
        },
      },
    },
  },

  -- surround: ysiw" wraps, cs"' changes, ds" deletes
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    opts = {},
  },

  -- illuminate: highlights all occurrences of word under cursor
  {
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    opts = {
      delay = 100,
      large_file_cutoff = 2000,
    },
    config = function(_, opts) require('illuminate').configure(opts) end,
  },
}
