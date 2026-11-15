-- migrated from the attached config for hyprland 0.56.1.
-- install as ~/.config/hypr/hyprland.lua; see migration-notes.md.
-- you can split this configuration into multiple files
-- create your files separately and then link them to this file like this:
-- require("mycolors") -- loads ~/.config/hypr/mycolors.lua


--###############
--## monitors ###
--###############

-- see https://wiki.hyprland.org/configuring/monitors/
hl.monitor({ output = "eDP-2", mode = "1920x1080@144", position = "0x0", scale = "1" })
hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "0x0", scale = "1" })
hl.monitor({ output = "", mode = "highres", position = "auto", scale = "auto", mirror = "HDMI-A-1" })
--##################
--## my programs ###
--##################

-- see https://wiki.hyprland.org/configuring/keywords/

-- set programs that you use
local terminal = "kitty"
local filemanager = "nautilus"
local menu = "/home/snezhinka/.local/bin/appdeck"
local run = "rofi -show run"
local firefox = "flatpak run org.mozilla.firefox"
-- local whatsapp = "wofi --show drun -q whatsapp"
local tg = "Telegram"
local lockscreen = "hyprlock"
local zen = "zen-beta"
local spotify = "spotify --enable-features=UseOzonePlatform --ozone-platform=wayland"
local screenshot = "hyprshot -m region"
local killitnow = "./killitnow.sh"

--################
--## autostart ###
--################

-- autostart necessary processes (like notifications daemons, status bars, etc.)
-- or execute your favorite apps at launch like this:

-- exec-once = $terminal
-- exec-once = nm-applet &
-- exec-once = hyprpm reload
-- exec-once = waybar
hl.on("hyprland.start", function() hl.exec_cmd("awww-daemon") end)
hl.on("hyprland.start", function() hl.exec_cmd("iio-hyprland") end)
-- hl.on("hyprland.start", function() hl.exec_cmd("wayves") end)
-- exec-once = ~/.config/hypr/scripts/set_wallpaper.sh
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"") -- for gtk4 apps
hl.on("hyprland.start", function() hl.exec_cmd("systemctl --user start hyprpolkitagent") end)
-- exec-once = workspace 5 silent, spotify-launcher
hl.on("hyprland.start", function() hl.exec_cmd("wl-paste --type text --watch cliphist store") end) -- stores only text data
hl.on("hyprland.start", function() hl.exec_cmd("wl-paste --type image --watch cliphist store") end) -- stores only image data
hl.on("hyprland.start", function() hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24") end)
hl.on("hyprland.start", function() hl.exec_cmd("/home/snezhinka/.local/bin/appdeck start") end)
hl.on("hyprland.start", function() hl.exec_cmd("udiskie") end)
-- brain shell layer rules — required for correct rendering
hl.layer_rule({ match = { namespace = "^brain-shell.*" }, no_anim = true })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true, ignore_alpha = 1 })
hl.on("hyprland.start", function()
    hl.exec_cmd("brain-shell")
end)

-- dynamic keybinds managed by brain shell's visual editor
local kb_path = os.getenv("HOME") .. "/.config/Brain_Shell/Brain_ShellKeybinds.lua"
local f = io.open(kb_path, "r")
if f then f:close(); dofile(kb_path) end
--############################
--## environment variables ###
--############################

-- see https://wiki.hyprland.org/configuring/environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
-- hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("GDK_SCALE", "1")
--- hl.env("XCURSOR_SIZE", "32")
--####################
--## look and feel ###
--####################

-- refer to https://wiki.hyprland.org/configuring/variables/

hl.config({
    xwayland = {
      force_zero_scaling = true,
    },
})
-- https://wiki.hyprland.org/configuring/variables/#general
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 13,
        border_size = 0,

        -- https://wiki.hyprland.org/configuring/variables/#variable-types for info about colors
        col = {
            active_border = "rgba(908ace00)",
            inactive_border = "rgba(00001900)",
        },

        -- set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- please see https://wiki.hyprland.org/configuring/tearing/ before you turn this on
        allow_tearing = true,

        layout = "scrolling",
    },
})

-- https://wiki.hyprland.org/configuring/variables/#decoration
hl.config({
    decoration = {
        rounding = 15,
        rounding_power = 2,

        -- change transparency of focused and unfocused windows
        active_opacity = 0.93,
        inactive_opacity = 0.7,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        -- https://wiki.hyprland.org/configuring/variables/#blur
        blur = {
            enabled = true,
            size = 10,
            passes = 3,

            vibrancy = 0.5,
        },
    },
})
-- https://wiki.hyprland.org/configuring/variables/#animations
hl.config({ animations = { enabled = true } })

-- niri-style slowdown: higher means slower; 1.0 restores original timing.
local animationslowdown = 1.5
hl.curve("wind",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("lll",    { type = "bezier", points = { {0.05, 0.8}, {0, 1.1} } })
hl.curve("winin",  { type = "bezier", points = { {0.1, 1.1}, {0.1, 1.1} } })
hl.curve("winout", { type = "bezier", points = { {0.3, -0.3}, {0, 1} } })
hl.curve("liner",  { type = "bezier", points = { {1, 1}, {1, 1} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 3 * animationslowdown,  bezier = "wind",   style = "popin" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 5 * animationslowdown,  bezier = "winin",  style = "gnome" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5 * animationslowdown,  bezier = "winout", style = "slidefade" })
-- hl.animation({ leaf = "windowsMove", enabled = true, speed = 10, bezier = "lll", style = "gnoe" })
hl.animation({ leaf = "border",      enabled = true, speed = 1 * animationslowdown,  bezier = "wind" })
-- hl.animation({ leaf = "borderAngle", enabled = true, speed = 30 * animationslowdown, bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10 * animationslowdown, bezier = "default" })

-- niri workspace-switch: 300 ms base, 900 ms with slowdown 3.0.
-- these control points exactly represent y = 1 - (1 - t)^3.
hl.curve("nirieaseoutcubic", { type = "bezier", points = { {1/3, 1}, {2/3, 1} } })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3 * animationslowdown, bezier = "nirieaseoutcubic", style = "slide" })

-- niri horizontal-view-movement: closest match is windowsmove.
-- this also affects other window movement and resizing, not just horizontal scrolling.
-- preserve the 0.75 damping ratio while slowing the spring by the same factor.
-- divide stiffness by slowdown squared and dampening by slowdown.
-- niri's epsilon = 0.0001 has no exposed equivalent; hyprland settles internally.
hl.curve("nirihorizontal", {
    type = "spring",
    mass = 1,
    stiffness = 600 / (animationslowdown * animationslowdown),
    dampening = (2 * 0.75 * math.sqrt(600)) / animationslowdown,
})
-- speed is required by the api; springs run on physical time, not this duration.
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, spring = "nirihorizontal" })
-- ref https://wiki.hyprland.org/configuring/workspace-rules/
-- "smart gaps" / "no gaps when only"
-- the inactive examples below retain their original legacy syntax for reference.
-- convert them to lua before enabling them.
--workspace = w[tv1], gapsout:0, gapsin:0
--workspace = f[1], gapsout:0, gapsin:0
--windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
--windowrule = rounding 2, floating:0, onworkspace:w[tv1]
--windowrule = bordersize 0, floating:0, onworkspace:f[1]
--windowrule = rounding 2, floating:0, onworkspace:f[1]

-- see https://wiki.hyprland.org/configuring/dwindle-layout/ for more
-- dwindle {
--    pseudotile = true # master switch for pseudotiling. enabling is bound to mainmod + p in the keybinds section below
--    preserve_split = true # you probably want this
--    force_split = 0
--}

-- see https://wiki.hyprland.org/configuring/master-layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hyprland.org/configuring/variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = -1, -- set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- if true disables the random hyprland logo / anime girl background. :(
    },
})


--############
--## input ###
--############

-- https://wiki.hyprland.org/configuring/variables/#input
hl.config({
    input = {
        kb_layout = "us,ru",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:win_space_toggle",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0.4, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- https://wiki.hyprland.org/configuring/variables/#gestures

-- example per-device config
-- see https://wiki.hyprland.org/configuring/keywords/#per-device-input-configs for more
-- hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })


--##################
--## keybindings ###
--##################

-- see https://wiki.hyprland.org/configuring/keywords/
local mainmod = "SUPER" -- sets "windows" key as main modifier

-- example obinds, see https://wiki.hyprland.org/configuring/binds/ for more
hl.bind(mainmod .. " + t", hl.dsp.exec_cmd(terminal))
hl.bind(mainmod .. " + c", hl.dsp.window.close())
hl.bind(mainmod .. " + m", hl.dsp.exit())
hl.bind(mainmod .. " + SHIFT + v", hl.dsp.exec_cmd("python ~/vpn.py"))
hl.bind(mainmod .. " + f", hl.dsp.exec_cmd(filemanager))
hl.bind(mainmod .. " + v", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainmod .. " + a", hl.dsp.exec_cmd(menu))
hl.bind(mainmod .. " + q", hl.dsp.exec_cmd(tg))
hl.bind(mainmod .. " + l", hl.dsp.exec_cmd(lockscreen))
hl.bind("ALT + Right", hl.dsp.send_shortcut({mods = "", key = "End"}))
hl.bind("ALT + Left", hl.dsp.send_shortcut({mods = "", key = "Home"}))
-- hl.bind("ALT + c", hl.dsp.send_shortcut({mods = "CTRL", key = "c"}))
-- hl.bind("ALT + v", hl.dsp.send_shortcut({mods = "CTRL", key = "v"}))

-- hl.bind("SUPER + o", hl.plugin.hymission.toggle)
hl.bind("SUPER + o", function()
    if hl.plugin and hl.plugin.hymission then
        hl.plugin.hymission.toggle()
    end
end)
hl.bind("F11", hl.dsp.window.fullscreen({ action = "toggle" }))
-- bind = $mainmod, p, pseudo, # dwindle
-- bind = $mainmod, j, togglesplit, # dwindle
hl.bind(mainmod .. " + b", hl.dsp.exec_cmd(firefox))
hl.bind(mainmod .. " + z", hl.dsp.exec_cmd(zen))
-- bind = $mainmod, s, swapsplit
hl.bind(mainmod .. " + i", hl.dsp.exec_cmd("clion"))
-- hl.bind("print", hl.dsp.exec_cmd(screenshot))
--bind = prtsc, exec, hyprshot -m region
--bind = $mainmod, r, exec, $run
hl.bind(mainmod .. " + k", hl.dsp.exec_cmd(killitnow))
-- move focus with mainmod + arrow keys
-- bind = $mainmod, left, movefocus, l
-- bind = $mainmod, right, movefocus, r
hl.bind(mainmod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainmod .. " + Down", hl.dsp.focus({ direction = "down" }))

-- switch workspaces with mainmod + [0-9]
hl.bind(mainmod .. " + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainmod .. " + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainmod .. " + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainmod .. " + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainmod .. " + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainmod .. " + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainmod .. " + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainmod .. " + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainmod .. " + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind(mainmod .. " + 0", hl.dsp.focus({ workspace = "10" }))

-- move active window to a workspace with mainmod + shift + [0-9]
hl.bind(mainmod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainmod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainmod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainmod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainmod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind(mainmod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind(mainmod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind(mainmod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind(mainmod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind(mainmod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))
hl.bind(mainmod .. " + w", hl.dsp.exec_cmd("~/.config/hypr/scripts/change_bing_bg.sh"))

-- example special workspace (scratchpad)
hl.bind(mainmod .. " + s", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainmod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "special:magic" }))

-- scroll through existing workspaces with mainmod + scroll
hl.bind(mainmod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainmod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.gesture({fingers = 3, direction = "Up", action = "workspace"})
hl.gesture({fingers = 3, direction = "Down", action = "workspace"})
-- move/resize windows with mainmod + lmb/rmb and dragging
hl.bind(mainmod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainmod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- laptop multimedia keys for volume and lcd brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true, locked = true })

-- requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--#############################
--## windows and workspaces ###
--#############################

-- see https://wiki.hyprland.org/configuring/window-rules/ for more
-- see https://wiki.hyprland.org/configuring/workspace-rules/ for workspace rules

-- example windowrule
-- windowrule = float,class:^(kitty)$,title:^(kitty)$
-- hl.window_rule({ name = "fulscreenzen", match = { class = "zen" }, maximize = true })
hl.window_rule({
    name = "zen-full-width",
    match = { class = "zen-beta" },
    scrolling_width = 1.0,
})

hl.window_rule({
    name = "kitty-half-width",
    match = { class = "^kitty$" },
    scrolling_width = 0.5,
    suppress_event = "maximize",
})

hl.config({
    input = {
        touchpad = {
            scroll_factor = 0.2,
            natural_scroll = true,
        },
    },
})
-- ignore maximize requests from apps. you'll probably like this.

-- fix some dragging issues with xwayland
-- windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
-- windowrulev2 = opacity 0.94 0.94,class:.*

-- layerrule = blur, wofi
-- layerrule = ignorezero, wofi
-- layerrule = ignorealpha 0.5, wofi

-- layerrule=  blur, waybar

hl.layer_rule({ name = "blur-eww", match = { namespace = "eww" }, blur = true })
-- layerrule=ignorezero, audio_menu

hl.config({ general = { layout = "scrolling" } })
hl.bind(mainmod .. " + Right", hl.dsp.layout("move +col"))
hl.bind(mainmod .. " + Left", hl.dsp.layout("move -col"))
hl.bind(mainmod .. " + SHIFT + period", hl.dsp.layout("movewindowto r"))
hl.bind(mainmod .. " + SHIFT + comma", hl.dsp.layout("movewindowto l"))
hl.bind(mainmod .. " + SHIFT + Left", hl.dsp.layout("swapcol l"))
hl.bind(mainmod .. " + SHIFT + Right", hl.dsp.layout("swapcol r"))
-- hl.bind(mainmod .. " + r", hl.dsp.layout("colresize +conf"))
hl.bind(mainmod .. " + r", function()
    hl.dispatch(hl.dsp.window.fullscreen_state({
        internal = 0,
        client = 0,
        action = "set",
    }))
    hl.dispatch(hl.dsp.layout("colresize +conf"))
end)
-- native scrolling settings replace the obsolete plugin:hyprscrolling category.
hl.config({
    scrolling = {
        column_width = 0.5,
        fullscreen_on_one_column = false,
        explicit_column_widths = "0.5, 1.1",
        focus_fit_method = 1,
    },
})
-- hl.gesture({ fingers = 3, direction = "Right", action = function() hl.dispatch(hl.dsp.layout("move -col")) end })
-- hl.gesture({ fingers = 3, direction = "Left", action = function() hl.dispatch(hl.dsp.layout("move +col")) end })
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "scroll_move",
    scale = 0.7,
})
-- .config/hypr/hyprland.lua


-- >>> brain shell startup >>>
-- dofile(os.getenv("HOME") .. "/.config/hypr/brain_shellkeybinds.lua")
-- dofile(os.getenv("HOME") .. "/path/to/brain_shell/src/config/autostart/brainshell-hyprland.lua")
-- <<< brain shell startup <<<

