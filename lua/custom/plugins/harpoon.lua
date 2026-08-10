-- harpoon: quick file switching (<leader>a add, <C-e> menu, <M-1..4> jump, <leader>fl list)

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>a', desc = 'Harpoon Add' },
    { '<C-e>', desc = 'Harpoon Menu' },
    { '<leader>fl', desc = 'Harpoon Telescope' },
    { '<M-1>', desc = 'Harpoon File 1' },
    { '<M-2>', desc = 'Harpoon File 2' },
    { '<M-3>', desc = 'Harpoon File 3' },
    { '<M-4>', desc = 'Harpoon File 4' },
    { '<C-p>', desc = 'Harpoon Prev' },
    { '<C-n>', desc = 'Harpoon Next' },
  },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- Telescope integration (Telescope list)
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      local conf = require('telescope.config').values
      local themes = require 'telescope.themes'

      local opts = themes.get_ivy {
        prompt_title = 'Harpoon List',
      }

      require('telescope.pickers')
        .new(opts, {
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer(opts),
          sorter = conf.generic_sorter(opts),
        })
        :find()
    end

    -- Basic operations (your preferred keybindings)
    vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon Add' })

    vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon Menu' })

    vim.keymap.set('n', '<leader>fl', function() toggle_telescope(harpoon:list()) end, { desc = 'Harpoon Telescope' })

    -- Navigation (Alt+number)
    vim.keymap.set('n', '<M-1>', function() harpoon:list():select(1) end, { desc = 'Harpoon File 1' })

    vim.keymap.set('n', '<M-2>', function() harpoon:list():select(2) end, { desc = 'Harpoon File 2' })

    vim.keymap.set('n', '<M-3>', function() harpoon:list():select(3) end, { desc = 'Harpoon File 3' })

    vim.keymap.set('n', '<M-4>', function() harpoon:list():select(4) end, { desc = 'Harpoon File 4' })

    -- Previous/Next
    vim.keymap.set('n', '<C-p>', function() harpoon:list():prev() end, { desc = 'Harpoon Prev' })

    vim.keymap.set('n', '<C-n>', function() harpoon:list():next() end, { desc = 'Harpoon Next' })
  end,
}
