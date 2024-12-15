return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    input = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    notifier = { enabled = true },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 7, total = 250 },
        easing = "linear",
      },
      spamming = 10,
      filter = function(buf)
        return vim.g.snacks_scroll ~= false
            and vim.b[buf].snacks_scroll ~= false
            and vim.bo[buf].buftype ~= "terminal"
      end,
    },
    styles = {
      input = {
        backdrop = false,
        position = "float",
        border = "rounded",
        title_pos = "center",
        height = 1,
        width = 60,
        relative = "editor",
        noautocmd = true,
        row = 2,
        -- relative = "cursor",
        -- row = -3,
        -- col = 0,
        wo = {
          winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
          cursorline = false,
        },
        bo = { filetype = "snacks_input" },
        keys = {
          i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i" },
          -- i_esc = { "<esc>", "stopinsert", mode = "i" },
          i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = "i" },
          i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i" },
          q = "cancel",
        },
      },
      zen = {
        enter = true,
        fixbuf = false,
        minimal = true,
        width = 80,
        height = 30,
        backdrop = { transparent = true, blend = 80 },
        keys = { q = false },
        wo = {
          winhighlight = "NormalFloat:Normal",
        },
      }
    },
  },
  -- Keybindings --
  keys = {
    { "<leader>z",  function() Snacks.zen() end,           desc = "Toggle zen mode" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
  }
}
