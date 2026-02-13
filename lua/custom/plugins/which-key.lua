-- Which-key: Shows all keybindings beautifully
-- Now includes LSP, completion, and all IDE features!

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'modern',
    spec = {
      -- File/Explorer
      { '<leader>e', desc = '󰙅 Explorer' },
      { '<leader>E', desc = '󰙅 Explorer (cwd)' },
      
      -- Search (Telescope)
      { '<leader>s', group = ' [S]earch' },
      { '<leader>sf', desc = 'Files' },
      { '<leader>sg', desc = 'Grep' },
      { '<leader>sh', desc = 'Help tags' },
      { '<leader>sk', desc = 'Keymaps' },
      { '<leader>sr', desc = 'Recent files' },
      { '<leader>sb', desc = 'Buffers' },
      { '<leader>sw', desc = 'Current word' },
      { '<leader>sd', desc = 'Diagnostics' },
      { '<leader>sc', desc = 'Commands' },
      { '<leader>sG', desc = 'Git files' },
      { '<leader>s.', desc = 'Recent (cwd)' },
      { '<leader>sR', desc = 'Resume' },
      { '<leader>s:', desc = 'Command history' },
      { '<leader>/', desc = '󰱼 Search in buffer' },
      
      -- LSP
      { '<leader>c', group = ' [C]ode' },
      { '<leader>ca', desc = 'Code Action' },
      { '<leader>rn', desc = 'Rename' },
      { '<leader>f', desc = 'Format' },
      { '<leader>D', desc = 'Type Definition' },
      { '<leader>ds', desc = 'Document Symbols' },
      { '<leader>ws', desc = 'Workspace Symbols' },
      { 'gd', desc = 'Goto Definition' },
      { 'gr', desc = 'Goto References' },
      { 'gI', desc = 'Goto Implementation' },
      { 'gD', desc = 'Goto Declaration' },
      { 'K', desc = 'Hover Documentation' },
      { '[d', desc = 'Previous Diagnostic' },
      { ']d', desc = 'Next Diagnostic' },
      
      -- Find (Harpoon)
      { '<leader>f', group = ' [F]ind' },
      { '<leader>fl', desc = 'Harpoon List' },
      
      -- Debug (DAP)
      { '<leader>d', group = ' [D]ebug' },
      { '<leader>db', desc = 'Toggle Breakpoint' },
      { '<leader>dB', desc = 'Conditional Breakpoint' },
      { '<leader>dc', desc = 'Continue' },
      { '<leader>dC', desc = 'Run to Cursor' },
      { '<leader>dt', desc = 'Terminate' },
      { '<leader>di', desc = 'Step Into' },
      { '<leader>do', desc = 'Step Over' },
      { '<leader>dO', desc = 'Step Out' },
      { '<leader>dr', desc = 'REPL' },
      { '<leader>du', desc = 'UI' },
      { '<leader>de', desc = 'Eval' },
      
      -- Git
      { '<leader>h', group = '󰊢 Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>g', group = '󰊢 [G]it' },
      
      -- Rust
      { '<leader>r', desc = ' [R]ust' },
      
      -- Toggle
      { '<leader>t', group = ' [T]oggle' },
      
      -- Write/Format
      { '<leader>w', group = '󰉋 [W]rite' },
      
      -- Harpoon
      { '<leader>a', desc = '󱡀 Harpoon Add' },
      { '<C-e>', desc = '󱡀 Harpoon Menu' },
      
      -- Quick access
      { '<leader><leader>', desc = '󰈞 Find Files' },
    },
  },
}
