-- Rosé Pine colorscheme for SketchyBar
return {
  -- Base colors
  base = 0xff191724,
  surface = 0xff1f1d2e,
  overlay = 0xff26233a,
  
  -- Text colors
  text = 0xffe0def4,
  muted = 0xff6e6a86,
  subtle = 0xff908caa,
  
  -- Accent colors (Rosé Pine palette)
  love = 0xffeb6f92,      -- red/pink
  gold = 0xfff6c177,      -- yellow/gold
  rose = 0xffea9a97,      -- rose/coral
  pine = 0xff31748f,      -- green
  foam = 0xff3e8fb0,      -- blue
  iris = 0xffc4a7e7,      -- purple
  
  -- Legacy color names for compatibility
  black = 0xff191724,
  white = 0xffe0def4,
  red = 0xffeb6f92,
  green = 0xff31748f,
  blue = 0xff3e8fb0,
  yellow = 0xfff6c177,
  orange = 0xffea9a97,
  magenta = 0xffc4a7e7,
  grey = 0xff6e6a86,
  transparent = 0x00000000,

  bar = {
    bg = 0xf0191724,       -- semi-transparent base
    border = 0xff26233a,   -- overlay
  },
  popup = {
    bg = 0xf01f1d2e,       -- semi-transparent surface
    border = 0xff6e6a86    -- muted
  },
  bg1 = 0xff26233a,        -- overlay
  bg2 = 0xff1f1d2e,        -- surface

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
