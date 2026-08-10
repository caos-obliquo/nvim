-- dadbod: database client (mysql, postgresql, sqlite, mongodb, redis)

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
      -- database ui settings
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

      -- auto-execute on save (optional, set to 0 to disable)
      vim.g.db_ui_auto_execute_table_helpers = 1

      -- use nvim notify for db messages
      vim.g.db_ui_use_nvim_notify = 1

      -- saved queries directory
      vim.g.db_ui_save_location = vim.fn.stdpath 'data' .. '/db_ui'

      -- icons
      vim.g.db_ui_icons = {
        expanded = {
          db = '▾ ',
          buffers = '▾ ',
          saved_queries = '▾ ',
          schemas = '▾ ',
          schema = '▾ \u{FB44}',
          tables = '▾ \u{F9F0}',
          table = '▾ ',
        },
        collapsed = {
          db = '▸ ',
          buffers = '▸ ',
          saved_queries = '▸ ',
          schemas = '▸ ',
          schema = '▸ \u{FB44}',
          tables = '▸ \u{F9F0}',
          table = '▸ ',
        },
        saved_query = '',
        new_query = '\u{F9EF}',
        tables = '\u{F9EA}',
        buffers = '\u{FB18}',
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
      -- auto-complete for sql
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
