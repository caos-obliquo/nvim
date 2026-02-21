-- Dadbod: Database client for MySQL, PostgreSQL, SQLite, MongoDB, Redis
-- Query databases directly from Neovim like DataGrip
--
-- Keybindings:
-- <leader>db = Toggle DB UI
-- <leader>dq = Execute query (visual mode)

return {
  {
    'tpope/vim-dadbod',
    cmd = 'DB',
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Database UI settings
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_winwidth = 40

      vim.g.db_ui_table_helpers = {
        mysql = {
          Count = 'SELECT COUNT(*) FROM {table}',
          Explain = 'EXPLAIN {last_query}',
        },
        postgresql = {
          Count = 'SELECT COUNT(*) FROM {table}',
          Explain = 'EXPLAIN ANALYZE {last_query}',
        },
      }

      -- Auto-execute on save (optional, set to 0 to disable)
      vim.g.db_ui_auto_execute_table_helpers = 1

      -- Use Telescope for DB selection (if available)
      vim.g.db_ui_use_nvim_notify = 1

      -- Saved queries directory
      vim.g.db_ui_save_location = vim.fn.stdpath 'data' .. '/db_ui'

      -- Icons
      vim.g.db_ui_icons = {
        expanded = {
          db = '▾ ',
          buffers = '▾ ',
          saved_queries = '▾ ',
          schemas = '▾ ',
          schema = '▾ פּ',
          tables = '▾ 藺',
          table = '▾ ',
        },
        collapsed = {
          db = '▸ ',
          buffers = '▸ ',
          saved_queries = '▸ ',
          schemas = '▸ ',
          schema = '▸ פּ',
          tables = '▸ 藺',
          table = '▸ ',
        },
        saved_query = '',
        new_query = '璘',
        tables = '離',
        buffers = '﬘',
        add_connection = '',
        connection_ok = '✓',
        connection_error = '✕',
      }
    end,
    keys = {
      { '<leader>db', '<cmd>DBUIToggle<cr>', desc = 'Toggle Database UI' },
      { '<leader>df', '<cmd>DBUIFindBuffer<cr>', desc = 'Find DB buffer' },
      { '<leader>dr', '<cmd>DBUIRenameBuffer<cr>', desc = 'Rename DB buffer' },
      { '<leader>dl', '<cmd>DBUILastQueryInfo<cr>', desc = 'Last query info' },
    },
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = 'vim-dadbod',
    ft = { 'sql', 'mysql', 'plsql' },
    init = function()
      -- Auto-complete for SQL
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'sql', 'mysql', 'plsql' },
        callback = function()
          local cmp = require 'cmp'
          local sources = vim.tbl_map(function(source) return { name = source.name } end, cmp.get_config().sources)

          table.insert(sources, { name = 'vim-dadbod-completion' })
          cmp.setup.buffer { sources = sources }
        end,
      })
    end,
  },
}
