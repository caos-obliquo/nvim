-- Modern Rust IDE setup using rustaceanvim
-- Replaces deprecated rust-tools.nvim for nvim 0.11+
--
-- Features:
-- - Full rust-analyzer integration
-- - DAP debugging support
-- - Crates.io integration
-- - Inlay hints
-- - Run/debug runnables

return {
  -- Modern Rust tooling (replaces rust-tools)
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            -- Rust-specific keymaps
            local map = function(keys, func, desc)
              vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Rust: ' .. desc })
            end
            
            map('<leader>rr', ':RustLsp runnables<CR>', 'Runnables')
            map('<leader>rd', ':RustLsp debuggables<CR>', 'Debuggables')
            map('<leader>re', ':RustLsp expandMacro<CR>', 'Expand Macro')
            map('<leader>rc', ':RustLsp openCargo<CR>', 'Open Cargo.toml')
            map('<leader>rp', ':RustLsp parentModule<CR>', 'Parent Module')
            map('<leader>rj', ':RustLsp joinLines<CR>', 'Join Lines')
            map('<leader>ra', ':RustLsp codeAction<CR>', 'Code Action')
          end,
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = {
                command = 'clippy',
              },
              cargo = {
                allFeatures = true,
              },
              inlayHints = {
                lifetimeElisionHints = {
                  enable = 'always',
                },
              },
            },
          },
        },
        dap = {
          adapter = {
            type = 'executable',
            command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
            name = 'rt_lldb',
          },
        },
      }
    end,
  },
  
  -- Crates.io integration
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup({
        popup = {
          border = 'rounded',
        },
      })
      
      vim.keymap.set('n', '<leader>ct', require('crates').toggle, { desc = 'Crates: Toggle' })
      vim.keymap.set('n', '<leader>cr', require('crates').reload, { desc = 'Crates: Reload' })
      vim.keymap.set('n', '<leader>cu', require('crates').update_crate, { desc = 'Crates: Update' })
      vim.keymap.set('n', '<leader>cU', require('crates').upgrade_crate, { desc = 'Crates: Upgrade' })
      vim.keymap.set('n', '<leader>ca', require('crates').update_all_crates, { desc = 'Crates: Update All' })
    end,
  },
}
