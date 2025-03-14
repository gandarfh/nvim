local status_ok, spectre = pcall(require, "spectre")
if not status_ok then
  return
end

spectre.setup({

  replace_engine = {
    ["sed"] = {
      cmd = "sed",
      args = {
        "-i",
        "",
        "-E",
      },
      options = {
        ["ignore-case"] = {
          value = "--ignore-case",
          icon = "[I]",
          desc = "ignore case",
        },
      },
      warn = true,
    },
  },

  default = {
    replace = {
      cmd = "sed",
    },
  },
})
