-- dap config: codelldb, delve, debugpy

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
  },
  keys = {
    { '<F5>',      function() require('dap').continue() end,          desc = 'Debug: Start/Continue' },
    { '<F1>',      function() require('dap').step_into() end,         desc = 'Debug: Step Into' },
    { '<F2>',      function() require('dap').step_over() end,         desc = 'Debug: Step Over' },
    { '<F3>',      function() require('dap').step_out() end,          desc = 'Debug: Step Out' },
    { '<F7>',      function() require('dapui').toggle() end,          desc = 'Debug: Toggle UI' },
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    {
      '<leader>B',
      function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
      desc = 'Debug: Conditional Breakpoint',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- mason dap setup
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = { 'delve', 'codelldb', 'debugpy' },
    }

    -- dap ui setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸', play = '▶', step_into = '⏎', step_over = '⏭',
          step_out = '⏮', step_back = 'b', run_last = '▶▶',
          terminate = '⏹', disconnect = '⏏',
        },
      },
    }

    -- auto open/close ui
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- rust: codelldb adapter
    local codelldb_path = vim.fn.stdpath('data') .. '/mason/bin/codelldb'

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path,
        args = { '--port', '${port}' },
      },
    }

    -- auto-detect rust binary from cargo.toml
    local function get_cargo_binary()
      -- try to find binary name from cargo.toml
      local cargo_toml = vim.fn.findfile('Cargo.toml', vim.fn.getcwd() .. ';')
      if cargo_toml ~= '' then
        local lines = vim.fn.readfile(cargo_toml)
        for _, line in ipairs(lines) do
          local name = line:match('^name%s*=%s*"(.+)"')
          if name then
            local binary = vim.fn.getcwd() .. '/target/debug/' .. name
            if vim.fn.filereadable(binary) == 1 then
              return binary
            end
          end
        end
      end
      -- fallback: ask user
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end

    dap.configurations.rust = {
      {
        name = 'Launch Rust binary',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    -- c/c++ also uses codelldb
    dap.configurations.c = {
      {
        name = 'Launch C binary',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = dap.configurations.c

    -- go: delve adapter
    require('dap-go').setup {
      delve = {
        detached = vim.fn.has('win32') == 0,
        -- auto-find the go binary
        path = vim.fn.stdpath('data') .. '/mason/bin/dlv',
      },
      -- dap-go adds these configurations automatically
    }

    -- python: debugpy adapter
    dap.adapters.python = {
      type = 'executable',
      command = vim.fn.stdpath('data') .. '/mason/bin/debugpy-adapter',
    }

    dap.configurations.python = {
      {
        name = 'Launch Python file',
        type = 'python',
        request = 'launch',
        program = '${file}',
        pythonPath = function()
          -- use venv if available, otherwise system python
          local venv = vim.fn.getcwd() .. '/.venv/bin/python'
          if vim.fn.filereadable(venv) == 1 then
            return venv
          end
          return '/usr/bin/python3'
        end,
      },
    }
  end,
}
