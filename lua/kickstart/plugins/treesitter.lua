-- Treesitter: Advanced syntax highlighting, text objects, and code understanding

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    priority = 100,
    config = function()
      local ts = require('nvim-treesitter')

      -- Languages to install (jonkero9 + your languages)
      local languages = {
        'bash',
        'c',
        'cpp',
        'c_sharp',
        'diff',
        'go',
        'html',
        'javascript',
        'typescript',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'rust',
        'toml',
        'vim',
        'vimdoc',
        'yaml',
        'zig',
      }

      local installed = ts.get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, languages)

      if #to_install > 0 then
        ts.install(to_install)
      end
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      -- Text objects (IDE feature - select functions, classes etc)
      local sel = require('nvim-treesitter-textobjects.select')
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        sel.select_textobject('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        sel.select_textobject('@function.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        sel.select_textobject('@class.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        sel.select_textobject('@class.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'aa', function()
        sel.select_textobject('@parameter.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ia', function()
        sel.select_textobject('@parameter.inner', 'textobjects')
      end)

      -- Move between text objects
      local mov = require('nvim-treesitter-textobjects.move')
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        mov.goto_next_start('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
        mov.goto_next_start('@class.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        mov.goto_previous_start('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
        mov.goto_previous_start('@class.outer', 'textobjects')
      end)

      -- Swap text objects
      local sw = require('nvim-treesitter-textobjects.swap')
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>sp', function()
        sw.swap_next({ '@parameter.inner' }, 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>sP', function()
        sw.swap_previous({ '@parameter.inner' }, 'textobjects')
      end)
    end,
  },
}
