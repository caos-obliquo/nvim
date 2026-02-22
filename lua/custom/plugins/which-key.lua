-- Which-key: Shows all keybindings beautifully
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'modern',
    spec = {
      -- ── File/Explorer ──────────────────────────────────────────────────
      { '<leader>e', desc = '󰙅 Explorer' },
      { '<leader>E', desc = '󰙅 Explorer (cwd)' },

      -- ── Search (Telescope) ─────────────────────────────────────────────
      { '<leader>s', group = ' [S]earch' },
      { '<leader>sf', desc = ' Files' },
      { '<leader>sg', desc = ' Grep' },
      { '<leader>sh', desc = '󰋖 Help tags' },
      { '<leader>sk', desc = '󰌌 Keymaps' },
      { '<leader>sr', desc = '󰋚 Recent files' },
      { '<leader>sb', desc = '󰓩 Buffers' },
      { '<leader>sw', desc = '󰛔 Current word' },
      { '<leader>sd', desc = ' Diagnostics' },
      { '<leader>sc', desc = ' Commands' },
      { '<leader>sG', desc = '󰊢 Git files' },
      { '<leader>s.', desc = '󰋚 Recent (cwd)' },
      { '<leader>sR', desc = '󰐎 Resume' },
      { '<leader>s:', desc = '󰋊 Command history' },
      { '<leader>sp', desc = '󰳔 Swap parameter next', mode = { 'n', 'x' } },
      { '<leader>sP', desc = '󰳔 Swap parameter prev', mode = { 'n', 'x' } },
      { '<leader>/', desc = '󰱼 Search in buffer' },

      -- ── LSP / Code ─────────────────────────────────────────────────────
      { '<leader>c', group = ' [C]ode' },
      { '<leader>ca', desc = '󰌵 Code Action', mode = { 'n', 'v' } },
      { '<leader>ci', desc = '󰏷 Incoming Calls' },
      { '<leader>cO', desc = '󰏸 Outgoing Calls' },
      { '<leader>rn', desc = '󰑕 Rename' },
      { '<leader>D', desc = '󰜁 Type Definition' },
      { '<leader>ds', desc = '󰆧 Document Symbols' },
      { '<leader>ws', desc = '󰅩 Workspace Symbols' },
      { '<leader>k', desc = '󰊕 Signature Help' },
      { '<leader>E', desc = '󰒡 Diagnostic Float' },
      { '<leader>zig', desc = '󰑓 Restart LSP' },
      { 'gd', desc = '󰈮 Goto Definition' },
      { 'gr', desc = '󰈇 Goto References' },
      { 'gI', desc = '󰈮 Goto Implementation' },
      { 'gD', desc = '󰈮 Goto Declaration' },
      { 'K', desc = '󰋖 Hover Documentation' },
      { '[d', desc = '󰒮 Previous Diagnostic' },
      { ']d', desc = '󰒭 Next Diagnostic' },

      -- ── Java (jdtls) ───────────────────────────────────────────────────
      { '<leader>co', desc = '󰒻 Java: Organize Imports' },
      { '<leader>cx', group = '󰬺 Java Extract' },
      { '<leader>cxv', desc = '󰫧 Extract Variable' },
      { '<leader>cxc', desc = '󰏿 Extract Constant' },
      { '<leader>cxm', desc = '󰊕 Extract Method', mode = 'v' },

      -- ── Refactoring ────────────────────────────────────────────────────
      { '<leader>r', group = '󰊕 [R]ust / Refactor' },
      { '<leader>re', desc = '󰬺 Extract Function', mode = 'x' },
      { '<leader>rv', desc = '󰫧 Extract Variable', mode = 'x' },
      { '<leader>ri', desc = '󰳤 Inline Variable', mode = { 'n', 'x' } },
      { '<leader>rb', desc = '󰬺 Extract Block' },

      -- ── Rust (rustaceanvim) ────────────────────────────────────────────
      { '<leader>rr', desc = ' Rust: Runnables' },
      { '<leader>rd', desc = ' Rust: Debuggables' },
      { '<leader>re', desc = '󰐕 Rust: Expand Macro' },
      { '<leader>rc', desc = ' Rust: Open Cargo.toml' },
      { '<leader>rp', desc = '󰘧 Rust: Parent Module' },
      { '<leader>rj', desc = '󰗈 Rust: Join Lines' },
      { '<leader>ra', desc = '󰌵 Rust: Code Action' },

      -- ── Crates.io ──────────────────────────────────────────────────────
      { '<leader>ct', desc = '󰏗 Crates: Toggle' },
      { '<leader>cr', desc = '󰑓 Crates: Reload' },
      { '<leader>cu', desc = '󰚰 Crates: Update' },
      { '<leader>cU', desc = '󰫢 Crates: Upgrade' },
      { '<leader>ca', desc = '󰚰 Crates: Update All' },

      -- ── Format ─────────────────────────────────────────────────────────
      { '<leader>f', group = '󰉶 [F]ormat / Find' },
      { '<leader>ff', desc = '󰉶 Format buffer' },
      { '<leader>fl', desc = '󱡀 Harpoon List' },

      -- ── Debug (DAP) ────────────────────────────────────────────────────
      { '<leader>d', group = ' [D]ebug' },
      { '<leader>db', desc = '󰃤 Toggle Breakpoint' },
      { '<leader>dB', desc = '󰃤 Conditional Breakpoint' },
      { '<leader>dc', desc = '󰐊 Continue' },
      { '<leader>dC', desc = '󰙿 Run to Cursor' },
      { '<leader>dt', desc = '󰙨 Test Class (Java) / Terminate' },
      { '<leader>dm', desc = '󰙨 Test Nearest Method (Java)' },
      { '<leader>di', desc = '󰆹 Step Into' },
      { '<leader>do', desc = '󰆸 Step Over' },
      { '<leader>dO', desc = '󰆺 Step Out' },
      { '<leader>dr', desc = '󰆘 REPL' },
      { '<leader>du', desc = '󰃢 UI' },
      { '<leader>de', desc = '󰎔 Eval' },

      -- ── Git ────────────────────────────────────────────────────────────
      { '<leader>g', group = '󰊢 [G]it' },
      { '<leader>gg', desc = '󰊢 LazyGit' },
      { '<leader>h', group = '󰊢 Git [H]unk', mode = { 'n', 'v' } },

      -- ── Trouble ────────────────────────────────────────────────────────
      { '<leader>x', group = '󰒡 Trouble' },
      { '<leader>xq', desc = '󰁨 Quickfix list' },
      { '<leader>xd', desc = ' Diagnostics' },
      { '<leader>xl', desc = '󰁨 Location list' },

      -- ── Harpoon ────────────────────────────────────────────────────────
      { '<leader>a', desc = '󱡀 Harpoon Add' },
      { '<C-e>', desc = '󱡀 Harpoon Menu' },
      { '<M-1>', desc = '󱡀 Harpoon File 1' },
      { '<M-2>', desc = '󱡀 Harpoon File 2' },
      { '<M-3>', desc = '󱡀 Harpoon File 3' },
      { '<M-4>', desc = '󱡀 Harpoon File 4' },
      { '<C-p>', desc = '󱡀 Harpoon Prev' },
      { '<C-n>', desc = '󱡀 Harpoon Next' },

      -- ── Toggle ─────────────────────────────────────────────────────────
      { '<leader>t', group = '󰔡 [T]oggle' },

      -- ── Write / Save ───────────────────────────────────────────────────
      { '<leader>w', group = '󰉋 [W]rite' },
      { '<leader>ss', desc = '󰆓 Save file' },

      -- ── Utilities ──────────────────────────────────────────────────────
      { '<leader>u', desc = '󰕍 Undotree' },
      { '<leader>z', desc = ' Zen Mode' },
      { '<leader>x', desc = ' Make executable' },
      { '<leader>y', desc = '󰅍 Yank to clipboard', mode = { 'n', 'v' } },
      { '<leader>Y', desc = '󰅍 Yank line to clipboard' },
      { '<leader>p', desc = '󰅌 Paste without losing register', mode = 'x' },

      -- ── Quickfix / Location ────────────────────────────────────────────
      { ']q', desc = '󰒭 Next quickfix' },
      { '[q', desc = '󰒮 Prev quickfix' },
      { ']l', desc = '󰒭 Next location' },
      { '[l', desc = '󰒮 Prev location' },

      -- ── Treesitter navigation ──────────────────────────────────────────
      { ']f', desc = '󰊕 Next function' },
      { '[f', desc = '󰊕 Prev function' },
      { ']m', desc = '󰅩 Next class' },
      { '[m', desc = '󰅩 Prev class' },
      { 'gnn', desc = '󰗆 Init selection' },
      { 'grn', desc = '󰗇 Increment node' },
      { 'grc', desc = '󰗇 Increment scope' },
      { 'grm', desc = '󰗅 Decrement node' },

      -- ── Quick access ───────────────────────────────────────────────────
      { '<leader><leader>', desc = '󰈞 Find Files' },
    },
  },
}
