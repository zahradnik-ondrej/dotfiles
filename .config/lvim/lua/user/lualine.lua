local function date_component(icon)
  local day = os.date("%a")
  local date = os.date("%d/%m/%Y")
  if type(day) ~= "string" or type(date) ~= "string" then
    return icon .. " ?? ??/??/????"
  end
  return icon .. " " .. day .. " " .. date
end

local function time_component(icon)
  local time = os.date("%H:%M:%S")
  return time and (icon .. " " .. time) or icon .. " ??"
end

local function ram_usage(icon)
  local handle = io.popen("free -m | awk '/Mem:/ {print $3 \"/\" $2 \"MB\"}'")
  if not handle then
    return icon .. " RAM: N/A"
  end
  local result = handle:read("*a")
  handle:close()
  return result and (icon .. " RAM: " .. result:gsub("\n", "")) or icon .. " RAM: N/A"
end

local function internet_status(icon)
  local ssid_handle = io.popen("nmcli -t -f NAME connection show --active | head -n 1")
  local ssid_result = ssid_handle and ssid_handle:read("*a")
  if ssid_handle then ssid_handle:close() end

  local ping_handle = io.popen("ping -c 1 8.8.8.8 | awk -F'/' 'END {print $5}'")
  local ping_result = ping_handle and ping_handle:read("*a")
  if ping_handle then ping_handle:close() end

  if ssid_result and ssid_result ~= "" and ping_result then
    local ping_number = tonumber(ping_result)
    if ping_number then
      local rounded_ping = math.floor(ping_number)
      return icon .. " " .. ssid_result:gsub("\n", "") .. " (" .. rounded_ping .. " ms)"
    end
    return icon .. " " .. ssid_result:gsub("\n", "") .. " (Ping: N/A)"
  elseif ssid_result and ssid_result ~= "" then
    return icon .. " " .. ssid_result:gsub("\n", "") .. " (Ping: N/A)"
  else
    return icon .. " Disconnected"
  end
end

lvim.builtin.lualine.options = {
  icons_enabled = true,
  section_separators = { left = '', right = '' },
}

local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.style = "lvim"

lvim.builtin.lualine.sections.lualine_a = {
  "mode",
}
lvim.builtin.lualine.sections.lualine_b = {}

local time_color = lvim.colorscheme == "dracula" and { fg = "#282a36", bg = "#bd93f9" } or nil
local date_color = lvim.colorscheme == "dracula" and { fg = "#282a36", bg = "#8be9fd" } or nil
local ram_color = lvim.colorscheme == "dracula" and { fg = "#282a36", bg = "#50fa7b" } or nil
local internet_status_color = lvim.colorscheme == "dracula" and { fg = "#282a36", bg = "#ff5555" } or nil

lvim.builtin.lualine.sections.lualine_c = {
  { function() return time_component("") end, color = time_color },
  { function() return date_component("") end, color = date_color },
  { function() return ram_usage("") end, color = ram_color },
  -- { function() return internet_status("📡") end, color = internet_status_color },
}

lvim.builtin.lualine.sections.lualine_x = {
  "selectioncount",
  components.branch,
  components.spaces,
}

lvim.builtin.lualine.sections.lualine_y = {
  components.filetype,
  components.encoding,
}

lvim.builtin.lualine.sections.lualine_z = {
  components.progress,
  components.location
}
