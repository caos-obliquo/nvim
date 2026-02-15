-- Treesitter: Advanced syntax highlighting and code understanding

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    priority = 100,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      local ok, configs = pcall(require, 'nvim-treesitter.configs')
      if not ok then return end

      configs.setup({
        -- Languages to install (jonkero9 + your languages)
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'c_sharp',
          'diff',
          'go',
          'html',
          'javascript',
          'typescript',
          'json',
          'jsonc',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'python',
          'query',
          'rust',
          'toml',
          'vim',
          'vimdoc',
          'yaml',
          'zig',
        },

        -- Auto-install missing parsers
        auto_install = true,

        -- Syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Smart indentation
        indent = {
          enable = true,
        },

        -- Incremental selection (jonkero9's keymaps)
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection   = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },

        -- Text objects (IDE feature - select functions, classes etc)
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']f'] = '@function.outer',
              [']m'] = '@class.outer',
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[m'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>sp'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>sP'] = '@parameter.inner',
            },
          },
        },
      })
    end,
  },
}
