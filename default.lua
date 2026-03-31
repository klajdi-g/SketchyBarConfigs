local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 14.0
    },
    color = colors.iris,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Semibold"],
      size = 12.0
    },
    color = colors.text,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  background = {
    height = 28,
    corner_radius = 8,
    border_width = 0,
    border_color = colors.subtle,
    color = colors.with_alpha(colors.surface, 0.5),
    image = {
      corner_radius = 8,
      border_color = colors.with_alpha(colors.subtle, 0.3),
      border_width = 1
    }
  },
  popup = {
    background = {
      border_width = 1,
      corner_radius = 8,
      border_color = colors.muted,
      color = colors.popup.bg,
      shadow = { drawing = true, color = colors.base },
    },
    blur_radius = 40,
  },
  padding_left = 5,
  padding_right = 5,
  scroll_texts = true,
})
