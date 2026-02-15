return {
  {
    'vimpostor/vim-tpipeline',
    config = function()
      vim.g.tpipeline_autoembed = 0
      vim.g.tpipeline_restore = 1
      vim.g.tpipeline_split = 0
      vim.g.tpipeline_clearstl = 1

      vim.opt.laststatus = 0
      vim.opt.cmdheight = 1
      vim.opt.showmode = false
      vim.opt.ruler = false

      local function truncate_path(path, max_len)
        if #path <= max_len then return path end
        local parts = {}
        for part in path:gmatch("[^/]+") do
          table.insert(parts, part)
        end
        if #parts <= 2 then return path end
        return parts[1] .. "/.../" .. parts[#parts]
      end

      _G.tpipeline_custom_stl = function()
        local mode_map = {
          n = { 'NORMAL', '#50fa7b' },
          i = { 'INSERT', '#8be9fd' },
          v = { 'VISUAL', '#ff79c6' },
          V = { 'V-LINE', '#f1fa8c' },
          ['\22'] = { 'V-BLOCK', '#ffb86c' },
          c = { 'COMMAND', '#ff5555' },
          t = { 'TERMINAL', '#bd93f9' },
        }

        local mode = vim.fn.mode()
        local m = mode_map[mode] or mode_map['n']
        local mode_name = m[1]
        local mode_color = m[2]

        local path = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
        path = truncate_path(path, 15)

        local filename = vim.fn.expand('%:t')
        if filename == '' then filename = '[No Name]' end
        local modified = vim.bo.modified and ' +' or ''

        return string.format(
          '#[fg=%s,bg=#1e3a5f,bold] %s #[fg=%s,bg=#1e3a5f]#[fg=#f8f8f2,bg=#1e3a5f] %s/%s%s ',
          mode_color, mode_name, mode_color, path, filename, modified
        )
      end

      vim.g.tpipeline_statusline = '%!v:lua._G.tpipeline_custom_stl()'

      vim.api.nvim_create_autocmd({ 'ModeChanged', 'FocusGained', 'BufEnter', 'WinEnter' }, {
        callback = function()
          pcall(vim.fn['tpipeline#update'])
        end,
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
  },
}
