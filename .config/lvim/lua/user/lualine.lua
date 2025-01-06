local function date_component()
  local day = os.date("%a")
  local date = os.date("%d/%m/%Y")
  if type(day) ~= "string" or type(date) ~= "string" then
    return "📅 ?? ??/??/????"
  end
  return "📅 " .. day:sub(1, 2) .. " " .. date
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

-- local function internet_status()
--   local ssid_handle = io.popen("nmcli -t -f NAME connection show --active | head -n 1")
--   local ssid_result = ssid_handle and ssid_handle:read("*a")
--   if ssid_handle then ssid_handle:close() end

--   local ping_handle = io.popen("ping -c 1 8.8.8.8 | awk -F'/' 'END {print $5}'")
--   local ping_result = ping_handle and ping_handle:read("*a")
--   if ping_handle then ping_handle:close() end

--   if ssid_result and ssid_result ~= "" and ping_result then
--     local ping_number = tonumber(ping_result)
--     if ping_number then
--       local rounded_ping = math.floor(ping_number)
--       return "📡 " .. ssid_result:gsub("\n", "") .. " (" .. rounded_ping .. " ms)"
--     end
--     return "📡 " .. ssid_result:gsub("\n", "") .. " (Ping: N/A)"
--   elseif ssid_result and ssid_result ~= "" then
--     return "📡 " .. ssid_result:gsub("\n", "") .. " (Ping: N/A)"
--   else
--     return "📡 Disconnected"
--   end
-- end

lvim.builtin.lualine.sections.lualine_c = {
  { time_component, color = { fg = "#282a36", bg = "#bd93f9" } },
  { date_component, color = { fg = "#282a36", bg = "#8be9fd" } },
  { ram_usage,      color = { fg = "#282a36", bg = "#50fa7b" } },
  -- { internet_status, color = { fg = "#282a36", bg = "#ff5555" } },
}
