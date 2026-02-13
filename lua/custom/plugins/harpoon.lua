-- Keybindings:
-- <leader>a = Add file to harpoon
-- <C-e> = Toggle harpoon menu
-- <leader>fl = Harpoon list in Telescope
-- <M-1> through <M-4> = Jump to harpoon file 1-4
-- <C-p> / <C-n> = Previous/Next harpoon file

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup()
    
    -- Telescope integration (your custom version - prettier!)
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end
      
      local conf = require('telescope.config').values
      local themes = require('telescope.themes')
      
      local opts = themes.get_ivy({
        prompt_title = 'Harpoon List'
      })
      
      require('telescope.pickers').new(opts, {
        finder = require('telescope.finders').new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer(opts),
        sorter = conf.generic_sorter(opts),
      }):find()
    end
    
    -- Basic operations (your preferred keybindings)
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon Add' })
    
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon Menu' })
    
    vim.keymap.set('n', '<leader>fl', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Harpoon Telescope' })
    
    -- Navigation (from kickstart - Alt+number is NICE!)
    vim.keymap.set('n', '<M-1>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon File 1' })
    
    vim.keymap.set('n', '<M-2>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon File 2' })
    
    vim.keymap.set('n', '<M-3>', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon File 3' })
    
    vim.keymap.set('n', '<M-4>', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon File 4' })
    
    -- Previous/Next (your original keybindings)
    vim.keymap.set('n', '<C-p>', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon Prev' })
    
    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():next()
    end, { desc = 'Harpoon Next' })
  end,
}
