-- debug.lua
-- DAP (Debug Adapter Protocol) configuration
-- Supports: Rust (codelldb), Go (delve), Python (debugpy), C/C++ (codelldb)

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

    -- Mason DAP setup
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = { 'delve', 'codelldb', 'debugpy' },
    }

    -- DAP UI setup
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

    -- Auto open/close UI
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- =========================================================
    -- RUST - codelldb adapter
    -- =========================================================
    local codelldb_path = vim.fn.stdpath('data') .. '/mason/bin/codelldb'

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path,
        args = { '--port', '${port}' },
      },
    }

    -- Auto-detect Rust binary from Cargo.toml
    local function get_cargo_binary()
      -- Try to find binary name from Cargo.toml
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
      -- Fallback: ask user
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end

    dap.configurations.rust = {
      {
        name = 'Launch Rust binary',
        type = 'codelldb',
        request = 'launch',
        program = get_cargo_binary,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        -- Run cargo build first automatically
        preLaunchTask = function()
          vim.fn.system('cargo build 2>&1')
          vim.notify('cargo build done', vim.log.levels.INFO)
        end,
      },
    }

    -- C/C++ also uses codelldb
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

    -- =========================================================
    -- GO - delve adapter
    -- =========================================================
    require('dap-go').setup {
      delve = {
        detached = vim.fn.has('win32') == 0,
        -- Auto-find the go binary
        path = vim.fn.stdpath('data') .. '/mason/bin/dlv',
      },
      -- These are the configurations dap-go adds automatically:
      -- 'Debug' - debug current package
      -- 'Debug test' - debug test under cursor
      -- 'Debug test (go.mod)' - debug all tests
    }

    -- =========================================================
    -- PYTHON - debugpy adapter
    -- =========================================================
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
          -- Use venv if available, otherwise system python
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
