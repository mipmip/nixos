return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  enabled = true,

  config = function()
    require("chatgpt").setup({
      api_key_cmd = 'cat /tmp/openai-api-key-plain'
    })
  end,

  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
