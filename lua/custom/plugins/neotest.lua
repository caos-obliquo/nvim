-- neotest: test runner with inline results

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',

    -- language adapters
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-go',
    'rouge8/neotest-rust',
    'nvim-neotest/neotest-jest',
    'marilari88/neotest-vitest',
  },
  config = function()
    local neotest = require 'neotest'

    neotest.setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          args = { '--log-level', 'DEBUG' },
          runner = 'pytest',
        },
        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
          args = { '-count=1', '-timeout=60s' },
        },
        require 'neotest-rust' {
          args = { '--no-capture' },
          dap_adapter = 'codelldb',
        },
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          env = { CI = true },
          cwd = function() return vim.fn.getcwd() end,
        },
        require 'neotest-vitest',
      },

      -- floating window for output
      output = {
        enabled = true,
        open_on_run = false,
      },

      -- inline diagnostics
      diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.ERROR,
      },

      -- status signs
      status = {
        enabled = true,
        virtual_text = false,
        signs = true,
      },

      -- icons
      icons = {
        running_animated = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
        passed = '✓',
        running = '●',
        failed = '✗',
        skipped = '⊘',
        unknown = '?',
      },
    }

    -- keymaps
    vim.keymap.set('n', '<leader>tt', function() neotest.run.run() end, { desc = 'Test: Run nearest' })

    vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand '%') end, { desc = 'Test: Run file' })

    vim.keymap.set('n', '<leader>ta', function() neotest.run.run(vim.fn.getcwd()) end, { desc = 'Test: Run all' })

    vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end, { desc = 'Test: Toggle summary' })

    vim.keymap.set('n', '<leader>to', function() neotest.output.open { enter = true, auto_close = true } end, { desc = 'Test: Show output' })

    vim.keymap.set('n', '<leader>tO', function() neotest.output_panel.toggle() end, { desc = 'Test: Toggle output panel' })

    vim.keymap.set('n', '<leader>tS', function() neotest.run.stop() end, { desc = 'Test: Stop' })

    vim.keymap.set('n', '<leader>tw', function() neotest.watch.toggle() end, { desc = 'Test: Toggle watch mode' })

    vim.keymap.set('n', '<leader>td', function() neotest.run.run { strategy = 'dap' } end, { desc = 'Test: Debug nearest' })

    -- navigation
    vim.keymap.set('n', ']r', function() neotest.jump.next { status = 'failed' } end, { desc = 'Next failed test' })

    vim.keymap.set('n', '[r', function() neotest.jump.prev { status = 'failed' } end, { desc = 'Prev failed test' })
  end,
}
