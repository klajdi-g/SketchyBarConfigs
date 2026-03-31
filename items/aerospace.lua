local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Aerospace workspace indicator
local aerospace_workspaces = sbar.add("item", "aerospace.workspaces", {
  label = {
    drawing = false,
  },
  background = {
    color = colors.bg1,
    border_color = colors.grey,
    border_width = 2,
    height = 28,
  },
  update_freq = 1,
})

-- Add some padding
sbar.add("item", "aerospace.padding", {
  width = 5,
})

aerospace_workspaces:subscribe("aerospace_workspace_change", function(env)
  sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
    aerospace_workspaces:set({
      icon = { string = focused_workspace:gsub("\n", "") },
    })
  end)
end)

aerospace_workspaces:subscribe("front_app_switched", function(env)
  sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
    aerospace_workspaces:set({
      icon = { string = focused_workspace:gsub("\n", "") },
    })
  end)
end)

-- Initial update
sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
  aerospace_workspaces:set({
    icon = { string = focused_workspace:gsub("\n", "") },
  })
end)
