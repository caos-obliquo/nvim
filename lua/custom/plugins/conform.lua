return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup {
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        -- Scripting
        lua = { 'stylua' },
        python = { 'ruff_format' },
        bash = { 'shfmt' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },

        -- Web
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },

        -- Systems (GNU style)
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        rust = { 'rustfmt' },
        zig = { 'zigfmt' },

        -- JVM
        java = { 'google_java_format' }, -- proper Java formatter

        -- Go
        go = { 'gofmt', 'goimports' },

        -- Infrastructure
        terraform = { 'terraform_fmt' },
      },

      -- clang-format: GNU style for C/C++
      formatters = {
        clang_format = {
          prepend_args = { '--style=GNU' },
        },
      },
    }

    vim.keymap.set('n', '<leader>f', function() require('conform').format { bufnr = 0 } end, { desc = 'Format buffer' })
  end,
}
