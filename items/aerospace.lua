local colors = require("colors")
local app_icons = require("helpers.app_icons")
local settings = require("settings")

-- Create workspace items (3 at a time)
local workspaces = {}
for i = 1, 3 do
  local workspace = sbar.add("item", "aerospace.workspace." .. i, {
    label = {
      width = 0,
    },
    icon = {
      width = 0,
    },
    padding_left = 8,
    padding_right = 8,
  })
  table.insert(workspaces, workspace)
end

-- Add bracket around all workspaces
sbar.add("bracket", { "/aerospace\\.workspace\\..*/" }, {
  background = {
    color = colors.bg1,
    border_color = colors.grey,
    border_width = 2,
    height = 28,
  }
})

-- Add padding
sbar.add("item", "aerospace.padding", {
  width = 5,
})

local current_workspace = 1
local all_workspaces = {}

-- Helper to get app icons for a workspace
local function get_workspace_apps(workspace_id)
  sbar.exec("aerospace list-windows --workspace " .. workspace_id .. " --format '%{app-name}'", function(result)
    if result and result ~= "" then
      local apps = ""
      local seen = {}
      for app in string.gmatch(result, '[^\r\n]+') do
        if not seen[app] then
          local icon = app_icons[app] or app_icons["Default"]
          apps = apps .. icon
          seen[app] = true
        end
      end
      return apps
    end
    return ""
  end)
end

-- Update workspace display
local function update_workspaces()
  sbar.exec("aerospace list-workspaces", function(result)
    all_workspaces = {}
    for ws in string.gmatch(result, '[^\r\n]+') do
      table.insert(all_workspaces, tonumber(ws))
    end
    
    sbar.exec("aerospace list-workspaces --focused", function(focused)
      current_workspace = tonumber(focused:gsub("\n", ""))
      
      -- Find the index of current workspace
      local current_index = 1
      for i, ws in ipairs(all_workspaces) do
        if ws == current_workspace then
          current_index = i
          break
        end
      end
      
      -- Get 3 workspaces: previous, current, next (or wrap around)
      local display_workspaces = {}
      local start_index = current_index - 1
      if start_index < 1 then start_index = #all_workspaces end
      
      for i = 0, 2 do
        local idx = ((start_index + i - 1) % #all_workspaces) + 1
        table.insert(display_workspaces, all_workspaces[idx])
      end
      
      -- Update each workspace display
      for i, ws_num in ipairs(display_workspaces) do
        local is_current = ws_num == current_workspace
        
        sbar.exec("aerospace list-windows --workspace " .. ws_num .. " --format '%{app-name}'", function(apps_result)
          local apps_string = ""
          if apps_result and apps_result ~= "" then
            local seen = {}
            for app in string.gmatch(apps_result, '[^\r\n]+') do
              if not seen[app] then
                local icon = app_icons[app] or app_icons["Default"]
                apps_string = apps_string .. icon
                seen[app] = true
              end
            end
          end
          
          workspaces[i]:set({
            label = {
              string = tostring(ws_num),
              width = "dynamic",
              color = is_current and colors.iris or colors.grey,
              font = {
                style = settings.font.style_map[is_current and "Bold" or "Semibold"],
                size = is_current and 13 or 12,
              },
            },
            icon = {
              string = apps_string,
              width = "dynamic",
              color = is_current and colors.iris or colors.grey,
            },
            background = {
              color = is_current and colors.with_alpha(colors.surface, 0.3) or colors.transparent,
              border_width = 0,
            }
          })
        end)
      end
    end)
  end)
end

-- Subscribe to changes
sbar.add("item", "aerospace.monitor", {
  drawing = false,
  updates = true,
}):subscribe("aerospace_workspace_change", update_workspaces)

-- Initial update
update_workspaces()

