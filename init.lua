-- Leader keys (must be before lazy)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Your aesthetic flag
vim.g.have_nerd_font = false

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.python3_host_prog = '/usr/bin/python3'

-- Basic options (Kickstart's sensible defaults)
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.colorcolumn = ''
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- ============================================
-- GAP FIX: Remove gap between nvim and tmux
-- ============================================
vim.opt.showmode = false      -- Remove -- INSERT -- text
vim.opt.cmdheight = 0         -- Remove command line gap (experimental)
vim.opt.laststatus = 2        -- Keep statusline visible
vim.opt.ruler = false         -- Remove ruler (redundant with statusline)

-- Keymaps (Kickstart essentials + your preferences)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

-- Keep cursor centered when scrolling (ThePrimeagen style!)
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up (centered)' })

-- Keep cursor centered when searching
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search result (centered)' })

-- Greatest remap ever (paste without losing register)
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without losing register' })

-- Quick save
vim.keymap.set('n', '<leader>ss', '<cmd>write<cr>', { desc = 'Save file' })

-- Diagnostic config (Kickstart style)
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  virtual_text = true,
}

-- Yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup: Kickstart base + your custom layer
require('lazy').setup({
  -- Kickstart's core plugins (LSP, Treesitter, Telescope, etc)
  { import = 'kickstart.plugins' },

  -- Your custom layer (Dracula, Rust IDE, Harpoon, DevOps)
  { import = 'custom.plugins' },
}, {
    rocks = { enabled = false },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
