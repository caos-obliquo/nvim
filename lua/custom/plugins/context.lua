-- treesitter-context: keep enclosing function/class context visible while scrolling
return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufReadPost',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesitter-context').setup {
      max_lines = 3,
      on_attach = function(buf)
        local disabled = { yaml = true, json = true, toml = true, dockerfile = true, terraform = true }
        return not disabled[vim.bo[buf].filetype]
      end,
    }
  end,
}
