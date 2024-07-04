-- Plugin: https://github.com/Mofiqul/dracula.nvim

return {
  {
    'Mofiqul/dracula.nvim',
    config = function(_, opts)
      require('dracula').setup()
      vim.cmd [[ colorscheme dracula ]]
    end
  },
}
