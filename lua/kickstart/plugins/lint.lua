return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        -- markup / config
        markdown = { 'markdownlint' },
        yaml = { 'yamllint' },
        json = { 'jsonlint' },

        -- infrastructure
        dockerfile = { 'hadolint' },
        terraform = { 'tflint' },

        -- shell
        bash = { 'shellcheck' },
        sh = { 'shellcheck' },
        zsh = { 'shellcheck' },

        -- web
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        html = { 'htmlhint' },
        css = { 'stylelint' },

        -- python
        python = { 'ruff' },

        -- systems
        rust = { 'clippy' }, -- uses cargo clippy, no Mason needed
        zig = { 'zlint' },

        -- c / c++ (gnu style)
        c = { 'cpplint', 'cppcheck' },
        cpp = { 'cpplint', 'cppcheck' },

        -- jvm
        java = { 'pmd' }, -- bug/error focused, no style enforcement

        -- go
        go = { 'golangcilint' },

        -- lua
        lua = { 'luacheck' },
      }

      -- cpplint: configure for gnu style
      lint.linters.cpplint = vim.tbl_deep_extend('force', lint.linters.cpplint or {}, {
        args = {
          '--filter=-legal/copyright,-build/include_subdir',
          '--linelength=80',
        },
      })

      -- trigger linting on these events
      -- note: clippy (rust) is slow so it only runs on save
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd('BufWritePost', {
        group = lint_augroup,
        pattern = { '*.rs' },
        callback = function() lint.try_lint 'clippy' end,
      })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable and vim.bo.filetype ~= 'rust' then lint.try_lint() end
        end,
      })
    end,
  },
}
