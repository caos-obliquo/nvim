-- Extra plugins inspired by jonkero9
-- LazyGit, hardtime, render-markdown, zen-mode, surround

return {
  -- LazyGit integration (beautiful Git TUI inside nvim!)
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

  -- Hardtime: Teaches you better vim habits
  -- (stops you from spamming hjkl!)
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

  -- Beautiful markdown rendering
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

  -- Zen mode: Distraction-free coding
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

  -- Surround: ysiw" to wrap, cs"' to change, ds" to delete
  -- Examples:
  --   ysiw"        → wrap word in quotes
  --   cs"'         → change " to '
  --   ds"          → delete surrounding "
  --   yss)         → wrap entire line in ()
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    opts = {},
  },

  -- Illuminate: highlights all occurrences of word under cursor
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
