-- disable netrw completely (neo-tree handles directories)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- force .env files to config filetype (never sh)
vim.filetype.add({
  pattern = {
    ['.*%.env.*'] = 'config',
    ['%.env'] = 'config',
  },
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '.env', '.env.*', '*.env' },
  callback = function()
    vim.bo.filetype = 'config'
  end,
})

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.python3_host_prog = '/usr/bin/python3'

-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 50
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.confirm = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- no swap or backup - undo history handles this
vim.o.swapfile = false
vim.o.backup = false

-- search
vim.o.hlsearch = false
vim.o.incsearch = true

-- no line wrap
vim.o.wrap = false

-- block cursor in all modes
vim.opt.guicursor = ''

-- terminal colors
vim.o.termguicolors = true

-- gap fix: remove gap between nvim and tmux
vim.opt.showmode = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 2
vim.opt.ruler = false

-- keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

-- keep cursor centered when scrolling and searching
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- move selected lines up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- join lines without moving cursor
vim.keymap.set('n', 'J', 'mzJ`z')

-- yank to system clipboard explicitly
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- delete to void register (keeps clipboard intact)
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- paste without losing register
vim.keymap.set('x', '<leader>p', [["_dP]])

-- c-c as escape in insert mode
vim.keymap.set('i', '<C-c>', '<Esc>')

-- disable ex mode
vim.keymap.set('n', 'Q', '<nop>')

-- search and replace word under cursor
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make current file executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- quick save
vim.keymap.set('n', '<leader>ss', '<cmd>write<cr>')

-- restart lsp when it gets stuck
vim.keymap.set('n', '<leader>zig', '<cmd>LspRestart<cr>')

-- auto-format paragraph keeping cursor position
vim.keymap.set('n', '=ap', "ma=ap'a")

-- quickfix list navigation
vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '[q', '<cmd>cprev<CR>zz')

-- location list navigation
vim.keymap.set('n', ']l', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '[l', '<cmd>lprev<CR>zz')

-- diagnostics
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  virtual_text = true,
}

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('trim-whitespace', { clear = true }),
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- lazy bootstrap
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'kickstart.plugins' },
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
