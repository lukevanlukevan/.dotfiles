return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[




▗▖   ▗▞▀▜▌▄▄▄▄▄ ▄   ▄ ▗▖  ▗▖▄ ▄▄▄▄  
▐▌   ▝▚▄▟▌ ▄▄▄▀ █   █ ▐▌  ▐▌▄ █ █ █ 
▐▌        █▄▄▄▄  ▀▀▀█ ▐▌  ▐▌█ █   █ 
▐▙▄▄▖           ▄   █  ▝▚▞▘ █       
                 ▀▀▀                
      ]],
      },
    },
    picker = {
      hidden = true,
      sources = {
        files = {
          hidden = true,
          -- ignored = true,
          -- exclude = {
          -- "**/.git/*",
          --},
        },
      },
    },
  },
  keys = {
    {
      "<leader>H",
      function()
        require("snacks").dashboard.open()
      end,
      desc = "Open Snacks Dashboard",
    },
    {
      "<leader>bb",
      function()
        require("snacks").picker.buffers({
          on_show = function()
            vim.cmd.stopinsert()
          end,
          win = {
            input = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
            list = { keys = { ["d"] = "bufdelete" } }, -- not sure how this works??
          },
        })
      end,
      desc = "Picker (Buffers)",
    },
  },
}
