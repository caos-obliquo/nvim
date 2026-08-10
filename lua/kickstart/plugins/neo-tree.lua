-- neo-tree file explorer (opens on the right)

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute({ toggle = true, position = 'right' })
      end,
      desc = 'Explorer (toggle)',
    },
    {
      '<leader>E',
      function()
        require('neo-tree.command').execute({ toggle = true, position = 'right', dir = vim.uv.cwd() })
      end,
      desc = 'Explorer (cwd)',
    },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
    source_selector = { winbar = false },
    
    -- opens on the right so the code doesn't shift
    window = {
      position = 'right',
      width = 35,
      mappings = {
        ['<space>'] = 'none',
        ['h'] = 'close_node',
        ['l'] = 'open',
        ['<cr>'] = 'open',
        ['o'] = 'open',
        ['s'] = 'open_split',
        ['v'] = 'open_vsplit',
        ['t'] = 'open_tabnew',
        ['C'] = 'close_node',
        ['z'] = 'close_all_nodes',
        ['Z'] = 'expand_all_nodes',
        ['R'] = 'refresh',
        ['a'] = 'add',
        ['A'] = 'add_directory',
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['q'] = 'close_window',
      },
    },
    
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
        hijack_netrw_behavior = 'disabled',
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          'node_modules',
          '.git',
          '.DS_Store',
        },
      },
    },
    
    default_component_configs = {
      git_status = {
        symbols = {
          added     = '',
          modified  = '',
          deleted   = '',
          renamed   = '➜',
          untracked = '★',
          ignored   = '◌',
          unstaged  = '✗',
          staged    = '✓',
          conflict  = '',
        },
      },
    },
  },
}
