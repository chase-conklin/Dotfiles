return {
  {
    'startup-nvim/startup.nvim',
    dependencies = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'},
    config = function(_, opts)
      require('startup').setup({theme = 'dashboard'})
    end
  }
}
