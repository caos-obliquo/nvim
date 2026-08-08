return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup {
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        config = {},  -- .env files, never format
        -- scripting
        lua = { 'stylua' },
        python = { 'ruff_format' },
        bash = { 'shfmt' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },

        -- web
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },

        -- systems (gnu style)
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        rust = { 'rustfmt' },
        zig = { 'zigfmt' },

        -- jvm
        java = { 'google_java_format' }, -- proper Java formatter

        -- go
        go = { 'gofmt', 'goimports' },

        -- infrastructure
        terraform = { 'terraform_fmt' },
      },

      -- clang-format: gnu style for c/c++
      formatters = {
        clang_format = {
          prepend_args = { '--style=GNU' },
        },
      },
    }

    vim.keymap.set('n', '<leader>f', function() require('conform').format { bufnr = 0 } end, { desc = 'Format buffer' })
  end,
}
