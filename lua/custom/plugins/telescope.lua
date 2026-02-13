-- telescope fuzzy finder
-- inspired by Teej and the need for throwing conventional IDEs away
--
-- KEYBINDINGS:
-- <leader>sf = find files
-- <leader>sg = live grep (search text in files)
-- <leader>sh = search help tags (TJ style!)
-- <leader>sk = search keymaps
-- <leader>sr = recent files (oldfiles)
-- <leader>sb = search buffers
-- <leader>sw = search current word
-- <leader>sd = search diagnostics
-- <leader>sc = search commands
-- <leader>s. = search recent files (in current directory)
-- <leader>/ = search in current buffer

return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  version = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      enabled = vim.fn.executable 'make' == 1,
    },
  },
  keys = {
    -- Files
    { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
    { '<leader><leader>', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    
    -- Grep/Search
    { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = '[S]earch by [G]rep' },
    { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [W]ord' },
    
    -- Recent/Buffers
    { '<leader>sr', '<cmd>Telescope oldfiles<cr>', desc = '[S]earch [R]ecent files' },
    { '<leader>sb', '<cmd>Telescope buffers<cr>', desc = '[S]earch [B]uffers' },
    { '<leader>s.', '<cmd>Telescope oldfiles cwd_only=true<cr>', desc = '[S]earch Recent (cwd)' },
    
    -- Help/Documentation (TJ DeVries style!)
    { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elp' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = '[S]earch [K]eymaps' },
    { '<leader>sc', '<cmd>Telescope commands<cr>', desc = '[S]earch [C]ommands' },
    
    -- Diagnostics/Git
    { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics' },
    { '<leader>sG', '<cmd>Telescope git_files<cr>', desc = '[S]earch [G]it files' },
    
    -- Search in current buffer
    { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Search in buffer' },
    
    -- Advanced
    { '<leader>sR', '<cmd>Telescope resume<cr>', desc = '[S]earch [R]esume' },
    { '<leader>s:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
  },
  
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    
    telescope.setup({
      defaults = {
        prompt_prefix = '  ',
        selection_caret = '  ',
        
        -- IMPORTANT: Results layout - preview on RIGHT
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        
        sorting_strategy = 'ascending',
        
        mappings = {
          i = {
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-c>'] = actions.close,
            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,
            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
          },
          n = {
            ['<esc>'] = actions.close,
            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,
            ['j'] = actions.move_selection_next,
            ['k'] = actions.move_selection_previous,
            ['H'] = actions.move_to_top,
            ['M'] = actions.move_to_middle,
            ['L'] = actions.move_to_bottom,
            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,
            ['gg'] = actions.move_to_top,
            ['G'] = actions.move_to_bottom,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
          },
        },
      },
      
      pickers = {
        find_files = {
          theme = 'dropdown',
          previewer = false,
        },
        buffers = {
          theme = 'dropdown',
          previewer = false,
          initial_mode = 'normal',
        },
        oldfiles = {
          theme = 'dropdown',
          previewer = false,
        },
      },
      
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    })
    
    -- Load fzf extension if available
    pcall(telescope.load_extension, 'fzf')
  end,
}
