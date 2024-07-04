-- Plugin: https://github.com/numToStr/Comment.nvim

return {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    config = function(_, opts)
      require('Comment').setup()
    end

}
