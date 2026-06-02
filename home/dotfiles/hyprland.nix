{ config, lib, pkgs, ... }: 
let
    cfg = config.hyprland.custom;
    inline = lib.generators.mkLuaInline;
in {
    config = {
        home.packages = with pkgs; [
            grim
            grimblast
            slurp
            awww
        ];

        wayland.windowManager.hyprland =  {
            enable = true;
            systemd.enable = true;
            configType = "lua";

            settings = {
                monitor = cfg.monitors;
                device = cfg.devices;

                env = [
                    { _args = [ "ELECTRON_OZONE_PLATFORM_HINT" "auto" ]; }
                    { _args = [ "HYPRCURSOR_SIZE" "24" ]; }
                    { _args = [ "XCURSOR_SIZE" "24" ]; }
                ];

                on = {
                    _args = [
                        "hyprland.start"
                        (inline ''
                            function()
                            ${lib.concatStringsSep "\n  " (map (cmd: "hl.exec_cmd(\"${cmd}\")") [
                                "dbus-update-activation-environment --systemd --all"
                                "systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_RUNTIME_DIR"
                                "waybar"
                                "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh"
                                "blueman-applet"
                                "wl-paste -t text --watch cliphist store"
                                "awww-daemon"
                                "hypridle"
                            ] ++ cfg.autostarts)}
                            end
                        '')
                    ];
                };

                config = {
                    general = {
                        gaps_in = 5;
                        gaps_out = 10;
                        border_size = 2;
                        "col.active_border" = "rgb(ca9ee6)";
                        "col.inactive_border" = "rgb(3b4252)";
                        layout = "dwindle";
                    };

                    decoration = {
                        rounding = 10;
                        blur = {
                            enabled = true;
                            size = 3;
                            passes = 1;
                            vibrancy = 0.16;
                        };
                    };

                    animations = {
                        enabled = true;
                    };

                    binds = {
                        scroll_event_delay = 0;
                    };

                    input = lib.mkMerge [
                        {
                            follow_mouse = 1;
                            float_switch_override_focus = 0;
                            numlock_by_default = true;
                            force_no_accel = false;
                            touchpad.natural_scroll = true;
                            sensitivity = 0.5;
                        }
                        cfg.inputs
                    ];
                };

                bind = let
                    exec = cmd: options: inline (
                        if options == "" then "hl.dsp.exec_cmd(\"${cmd}\")"
                        else "hl.dsp.exec_cmd(\"${cmd}\", ${options})"
                    );
                in builtins.concatLists [
                    [ # Programs
                        { _args = [ "MOD1 + RETURN" (exec "kitty" "") ]; }
                        { _args = [ "MOD1 + SHIFT + RETURN" (exec "kitty" "{ float = true}") ]; }
                        { _args = [ "SUPER + E" (exec "nautilus --new-window" "{ float = true }") ]; }
                    ]
                    [ # Hyprland
                        { _args = [ "MOD1 + SPACE" (exec "wofi --show drun" "") ]; }
                        { _args = [ "MOD1 + S" (inline "hl.dsp.window.swap({ next = true })") ]; }
                        { _args = [ "MOD1 + Q" (inline "hl.dsp.window.close()") ]; }
                        { _args = [ "MOD1 + SHIFT + Q" (inline "hl.dsp.window.kill()") ]; }
                        { _args = [ "MOD1 + E" (inline "hl.dsp.window.pseudo({ \"toggle\" })") ]; }
                        { _args = [ "MOD1 + F" (inline "hl.dsp.window.fullscreen(\"maximized\", \"toggle\")") ]; }
                        { _args = [ "MOD1 + mouse:273" (inline "hl.dsp.window.resize()") (inline "{ mouse = true }") ]; }
                        { _args = [ "MOD1 + W" (inline "hl.dsp.window.float({ \"toggle\" })") ]; }
                        { _args = [ "MOD1 + W" (inline "hl.dsp.window.center()") ]; }
                    ]
                    [ # System / Media
                        { _args = [ "SUPER + L" (exec "hyprlock" "") ]; }
                        { _args = [ "MOD1 + SHIFT + P" (exec "wlogout" "") ]; }
                        { _args = [ "Print" (exec "grimblast copy area" "") ]; }
                        { _args = [ "SUPER + Print" (exec "grimblast copy screen" "") ]; }
                        { _args = [ "SUPER + mouse_up" (exec "pamixer -d 1" "") ]; }
                        { _args = [ "SUPER + mouse_down" (exec "pamixer -i 1" "") ]; }
                        { _args = [ "XF86AudioLowerVolume" (exec "pamixer -d 5" "") ]; }
                        { _args = [ "XF86AudioRaiseVolume" (exec "pamixer -i 5" "") ]; }
                        { _args = [ "XF86AudioMute" (exec "pamixer -t" "") ]; }
                        { _args = [ "XF86MonBrightnessUp" (exec "light -A 5" "") ]; }
                        { _args = [ "XF86MonBrightnessDown" (exec "light -U 5" "") ]; }
                    ]
                    [ # Workspace Navigation
                        { _args = [ "MOD1 + H" (inline "hl.dsp.focus({ direction = \"l\" })") ]; }
                        { _args = [ "MOD1 + L" (inline "hl.dsp.focus({ direction = \"r\" })") ]; }
                        { _args = [ "MOD1 + K" (inline "hl.dsp.focus({ direction = \"u\" })") ]; }
                        { _args = [ "MOD1 + J" (inline "hl.dsp.focus({ direction = \"d\" })") ]; }
                    ]
                    (map (i: {
                        _args = [ 
                            "MOD1 + ${toString i}"
                            (inline "hl.dsp.focus({ workspace = ${if i == 0 then "10" else toString i} })")
                        ];
                    }) (builtins.genList (x: x) 10))
                    [ # Move active Window
                        { _args = [ "MOD1 + SHIFT + H" (inline "hl.dsp.window.move({ direction = \"l\" })") ]; }
                        { _args = [ "MOD1 + SHIFT + L" (inline "hl.dsp.window.move({ direction = \"r\" })") ]; }
                        { _args = [ "MOD1 + SHIFT + K" (inline "hl.dsp.window.move({ direction = \"u\" })") ]; }
                        { _args = [ "MOD1 + SHIFT + J" (inline "hl.dsp.window.move({ direction = \"d\" })") ]; }
                        { _args = [ "MOD1 + mouse:272" (inline "hl.dsp.window.drag()") (inline "{ mouse = true }") ]; }
                    ]
                    (map (i: {
                        _args = [ 
                            "MOD1 + SHIFT + ${toString i}"
                            (inline "hl.dsp.window.move({ follow = true, workspace = ${if i == 0 then "10" else toString i} })")
                        ];
                    }) (builtins.genList (x: x) 10))
                    (map (i: {
                        _args = [ 
                            "MOD1 + CTRL + ${toString i}"
                            (inline "hl.dsp.window.move({ follow = false, workspace = ${if i == 0 then "10" else toString i} })")
                        ];
                    }) (builtins.genList (x: x) 10))
                    [ # Misc
                        { _args = [ "SUPER + SHIFT + M" (exec "~/.config/hypr/scripts/wallpapers.sh" "") ]; }
                        { # reload waybar
                            _args = [ 
                                "SUPER + SHIFT + W"
                                (inline ''
                                    function()
                                        hl.dsp.window.close({ window = "class:^(waybar)" })
                                        hl.dsp.exec_cmd("waybar")
                                    end
                                '')
                            ];
                        }
                    ]
                ];

                window_rule = [
                    { 
                        match.class = "wofi";
                        float = true;
                        size = "800 600";
                        center = true;
                    }
                ];

                gesture = [
                    {
                        fingers = 3;
                        direction = "horizontal";
                        action = "workspace";
                    }
                    {
                        fingers = 3;
                        direction = "pinch";
                        action = "fullscreen";
                    }
                ];
            };
        };

        home.file = {
            ".config/hypr/frappe.conf".source = ./assets/hypr/frappe.conf;
            ".config/hypr/hyprlock.conf".source = ./assets/hypr/hyprlock.conf;
            ".config/hypr/scripts/wallpapers.sh".source = ./assets/hypr/scripts/wallpapers.sh;
        };
    };

    options.hyprland.custom = {
        monitors = lib.mkOption {
            type = lib.types.listOf lib.types.attrs;
            default = [
                {
                    output = "";
                    mode = "preferred";
                    position = "auto";
                    scale = 1;
                }
            ];
            description = "Hyprland monitor configuration";
        };
        autostarts = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Commands to execute once at the start of the session";
        };
        inputs = lib.mkOption {
            type = lib.types.attrs;
            default = { 
                kb_layout = "ch";
                kb_variant = "";
                kb_model = "";
                kb_options = "";
                kb_rules = "";
            };
            description = "Hyprland input configuration";
        };
        devices = lib.mkOption {
            type = lib.types.listOf lib.types.attrs;
            default = [];
            description = "Hyprland device configuration";
        };
    };
}
