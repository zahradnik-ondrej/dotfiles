local function date_component()
  local day = os.date("%a")
  local date = os.date("%d/%m/%Y")
  if type(day) ~= "string" or type(date) ~= "string" then
    return "📅 ?? ??/??/????"
  end
  return "📅 " .. day .. " " .. date
end

local function time_component()
  local time = os.date("%H:%M:%S")
  return time and ("⏰ " .. time) or "⏰ ??"
end

local function ram_usage()
  local handle = io.popen("free -m | awk '/Mem:/ {print $3 \"/\" $2 \"MB\"}'")
  if not handle then
    return "🧠 RAM: N/A"
  end
  local result = handle:read("*a")
  handle:close()
  return result and ("🧠 RAM: " .. result:gsub("\n", "")) or "🧠 RAM: N/A"
end

local function internet_status()
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
      return "📡 " .. ssid_result:gsub("\n", "") .. " (" .. rounded_ping .. " ms)"
    end
    return "📡 " .. ssid_result:gsub("\n", "") .. " (Ping: N/A)"
  elseif ssid_result and ssid_result ~= "" then
    return "📡 " .. ssid_result:gsub("\n", "") .. " (Ping: N/A)"
  else
    return "📡 Disconnected"
  end
end

lvim.builtin.lualine.options = {
  icons_enabled = true,
  -- component_separators = { left = '', right = '' },
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
  { time_component,  color = time_color },
  { date_component,  color = date_color },
  { ram_usage,       color = ram_color },
  -- { internet_status, color = internet_status_color },
}

lvim.builtin.lualine.sections.lualine_x = {
  "selectioncount",
  components.branch,
  components.spaces,
  -- components.lsp,
}

lvim.builtin.lualine.sections.lualine_y = {
  components.filetype,
  components.encoding,
}

lvim.builtin.lualine.sections.lualine_z = {
  components.progress,
  components.location
}
