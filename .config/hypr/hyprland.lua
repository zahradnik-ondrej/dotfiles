local home = os.getenv("HOME")
package.path = home .. "/.config/lvim/lua/?.lua;" .. package.path
local pal = require("user.palette")

local function rgba(hex, alpha)
    return ("rgba(%s%s)"):format((hex:gsub("#", "")):lower(), alpha)
end

local terminal    = "alacritty"
local fileManager = "nautilus"
local menu        = "rofi -show drun"
local mainMod     = "SUPER"

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.0 })

local internal_outputs, internal_off, pending = {}, nil, false

local function apply_monitors()
    pending = false
    local has_external, discovered = false, false
    for _, m in ipairs(hl.get_monitors()) do
        if m.name:find("^eDP") or m.name:find("^LVDS") or m.name:find("^DSI") then
            if not internal_outputs[m.name] then
                internal_outputs[m.name] = true
                discovered = true
            end
        elseif not (m.name:find("^FALLBACK") or m.name:find("^HEADLESS")) then
            has_external = true
        end
    end

    if internal_off == has_external and not discovered then return end
    internal_off = has_external

    for name in pairs(internal_outputs) do
        hl.monitor({
            output = name,
            mode = "preferred",
            position = "auto",
            scale = 1.0,
            disabled = has_external,
        })
    end
end

local function sync_monitors()
    if pending then return end
    pending = true
    hl.timer(apply_monitors, { timeout = 250, type = "oneshot" })
end

hl.on("monitor.added", sync_monitors)
hl.on("monitor.removed", sync_monitors)
apply_monitors()

hl.env("PATH", home .. "/.local/bin:/usr/local/bin:/usr/bin")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd(home .. "/.hyprland/nightshift.sh")
    hl.exec_cmd("hypridle")
end)

hl.exec_cmd("sh -c 'echo $HYPRLAND_INSTANCE_SIGNATURE > " .. home .. "/.config/hypr/hyprland_signature.txt'")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border = { colors = { rgba(pal.accent, "ee"), rgba(pal.teal, "ee") }, angle = 45 },
            inactive_border = rgba(pal.bg_alt, "aa"),
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = { enabled = true, size = 3, passes = 1, vibrancy = 0.1696 },
    },
    animations = { enabled = true },
    dwindle = { preserve_split = true },
    master = { new_status = "master" },
    misc = { force_default_wallpaper = 0, disable_hyprland_logo = true },
    input = {
        kb_layout = "us,cz",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:win_space_toggle",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = { natural_scroll = false },
        numlock_by_default = true,
    },
    cursor = { no_hardware_cursors = 1, inactive_timeout = 1 },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd('nwg-drawer -fm "nautilus" -nocats -nofs -term "alacritty"'))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("gimp"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("inkscape"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("kicad"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("slack"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("Telegram"))

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("poweroff"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("reboot"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i, silent = true }))
end

hl.bind(mainMod .. " + TAB",        hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("PRINT",         hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(home .. "/.local/bin/ddc-brightness down"), { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(home .. "/.local/bin/ddc-brightness up"),   { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                      { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                    { locked = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                          { locked = true })
hl.bind("XF86AudioStop",         hl.dsp.exec_cmd("playerctl stop"),                          { locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { locked = true, repeating = true })
hl.bind(mainMod .. " + H",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),     { locked = true })
