local colors = require("colors")
local app_icons = require("helpers.app_icons")
local settings = require("settings")

local current_workspace = 1
local all_workspaces = {}

-- Create 3 separate workspace widgets with individual brackets
local workspaces = {}
local brackets = {}
for i = 1, 3 do
  local workspace = sbar.add("item", "aerospace.workspace." .. i, {
    label = {
      string = i,
      width = "dynamic",
    },
    icon = {
      string = "",
      width = "dynamic",
      font = "sketchybar-app-font:Regular:9.0",
    },
    padding_left = 6,
    padding_right = 6,
  })
  
  -- Individual bracket for each workspace
  local bracket = sbar.add("bracket", { "aerospace.workspace." .. i }, {
    background = {
      color = colors.bg1,
      border_color = colors.grey,
      border_width = 2,
      height = 28,
      corner_radius = 8,
      shadow = {
        drawing = false,
      }
    }
  })
  
  -- Padding between workspaces
  if i < 3 then
    sbar.add("item", "aerospace.space." .. i, {
      width = 5,
    })
  end
  
  table.insert(workspaces, workspace)
  table.insert(brackets, bracket)
end

-- Padding at the end
sbar.add("item", "aerospace.padding", {
  width = 5,
})

-- Update workspace display
local function update_workspaces()
  sbar.exec("aerospace list-workspaces --all", function(all_result)
    all_workspaces = {}
    for ws in string.gmatch(all_result, '%d+') do
      table.insert(all_workspaces, tonumber(ws))
    end
    
    sbar.exec("aerospace list-workspaces --focused", function(focused)
      current_workspace = tonumber(focused:match('%d+') or 1)
      
      -- Find the index of current workspace
      local current_index = 1
      for i, ws in ipairs(all_workspaces) do
        if ws == current_workspace then
          current_index = i
          break
        end
      end
      
      -- Get 3 workspaces: previous, current, next
      local display_workspaces = {}
      
      -- Prev
      local prev_idx = current_index - 1
      if prev_idx < 1 then prev_idx = #all_workspaces end
      table.insert(display_workspaces, all_workspaces[prev_idx])
      
      -- Current
      table.insert(display_workspaces, all_workspaces[current_index])
      
      -- Next
      local next_idx = current_index + 1
      if next_idx > #all_workspaces then next_idx = 1 end
      table.insert(display_workspaces, all_workspaces[next_idx])
      
      -- Track all apps shown globally to deduplicate across all 3 workspaces
      local global_seen = {}
      
      -- Update each workspace display
      for i = 1, 3 do
        local ws_num = display_workspaces[i]
        local is_current = ws_num == current_workspace
        
        -- Update bracket with shadow if current
        brackets[i]:set({
          background = {
            shadow = {
              drawing = is_current,
              color = colors.iris,
              angle = 45,
              distance = 2,
              blur = 5,
            }
          }
        })
        
        sbar.exec("aerospace list-windows --workspace " .. ws_num .. " --format '%{app-name}' 2>/dev/null || true", function(apps_result)
          local apps_string = ""
          
          if apps_result and apps_result ~= "" then
            local seen = {}
            local count = 0
            for app in string.gmatch(apps_result, '[^\r\n]+') do
              if app ~= "" and not seen[app] and not global_seen[app] and count < 4 then
                local icon = app_icons[app] or app_icons["Default"] or "•"
                apps_string = apps_string .. icon
                seen[app] = true
                global_seen[app] = true
                count = count + 1
              end
            end
          else
            -- Empty workspace, show a dash or nothing
            apps_string = ""
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
              color = colors.transparent,
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

-- Also monitor when apps switch
sbar.add("item", "aerospace.monitor2", {
  drawing = false,
  updates = true,
}):subscribe("front_app_switched", update_workspaces)

-- Initial update with a small delay
sbar.delay(0.1, update_workspaces)






