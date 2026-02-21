-- Neotest: Test runner with inline results
-- Runs tests with visual feedback directly in your editor
--
-- Keybindings:
-- <leader>tt = Run nearest test
-- <leader>tf = Run tests in current file
-- <leader>ta = Run all tests
-- <leader>ts = Toggle test summary
-- <leader>to = Show test output
-- <leader>tS = Stop nearest test

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',

    -- Language adapters
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

      -- Floating window for output
      output = {
        enabled = true,
        open_on_run = false,
      },

      -- Inline diagnostics
      diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.ERROR,
      },

      -- Status signs
      status = {
        enabled = true,
        virtual_text = false,
        signs = true,
      },

      -- Icons
      icons = {
        running_animated = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
        passed = '✓',
        running = '●',
        failed = '✗',
        skipped = '⊘',
        unknown = '?',
      },
    }

    -- Keymaps
    vim.keymap.set('n', '<leader>tt', function() neotest.run.run() end, { desc = 'Test: Run nearest' })

    vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand '%') end, { desc = 'Test: Run file' })

    vim.keymap.set('n', '<leader>ta', function() neotest.run.run(vim.fn.getcwd()) end, { desc = 'Test: Run all' })

    vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end, { desc = 'Test: Toggle summary' })

    vim.keymap.set('n', '<leader>to', function() neotest.output.open { enter = true, auto_close = true } end, { desc = 'Test: Show output' })

    vim.keymap.set('n', '<leader>tO', function() neotest.output_panel.toggle() end, { desc = 'Test: Toggle output panel' })

    vim.keymap.set('n', '<leader>tS', function() neotest.run.stop() end, { desc = 'Test: Stop' })

    vim.keymap.set('n', '<leader>tw', function() neotest.watch.toggle() end, { desc = 'Test: Toggle watch mode' })

    vim.keymap.set('n', '<leader>td', function() neotest.run.run { strategy = 'dap' } end, { desc = 'Test: Debug nearest' })

    -- Navigation
    vim.keymap.set('n', ']t', function() neotest.jump.next { status = 'failed' } end, { desc = 'Next failed test' })

    vim.keymap.set('n', '[t', function() neotest.jump.prev { status = 'failed' } end, { desc = 'Prev failed test' })
  end,
}
