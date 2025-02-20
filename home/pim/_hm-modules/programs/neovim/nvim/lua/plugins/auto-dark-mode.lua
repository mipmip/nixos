return {
  "f-person/auto-dark-mode.nvim",
  enabled = false,
  config = {
    update_interval = 1000,
    fallback = "light",
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
      vim.cmd("colorscheme solarized")
    end,
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light")
      vim.cmd("colorscheme solarized")
    end,
  },
}
